// 
//
// jsmndr.c -- json parser in qvm

#include "jsmndr.h"

void jsmndr_init(jsmndr_parser *parser) {
    parser->pos = 0;
    parser->toknext = 0;
    parser->toksuper = -1;
}

static jsmndrtok_t *jsmndr_alloc_token(jsmndr_parser *parser, jsmndrtok_t *tokens, size_t num_tokens) {
    jsmndrtok_t *tok;
    if (parser->toknext >= num_tokens) return NULL;
    tok = &tokens[parser->toknext++];
    tok->start = tok->end = -1;
    tok->size = 0;
    tok->parent = parser->toksuper;
    return tok;
}

static void jsmndr_fill_token(jsmndrtok_t *tok, jsmndrtype_t type, int start, int end) {
    tok->type = type;
    tok->start = start;
    tok->end = end;
    tok->size = 0;
}

/*
=================
jsmndr_copy_token

Copies a JSON token's text out of the parse buffer into dst, truncating to
dstSize - 1 and always null-terminating. json/tok point into jsonFileBuffer,
which is not null-terminated at the token boundary, so this must never read
past tok->end.
=================
*/
void jsmndr_copy_token( char *dst, int dstSize, const char *json, jsmndrtok_t *tok ) {
	int tokLen = tok->end - tok->start;
	if ( tokLen < 0 ) {
		tokLen = 0;
	}
	if ( tokLen >= dstSize ) {
		tokLen = dstSize - 1;
	}
	Q_strncpyz( dst, json + tok->start, tokLen + 1 );
}

int jsmndr_parse(jsmndr_parser *parser, const char *js, size_t len, jsmndrtok_t *tokens, unsigned int num_tokens) {
    int count = parser->toknext;
    int i;
    jsmndrtok_t *tok;
    jsmndrtype_t type; /* FIXED: Declared at function top for C89 */
    int start;         /* FIXED: Declared at function top for C89 */

    for (; parser->pos < len && js[parser->pos] != '\0'; parser->pos++) {
        char c = js[parser->pos];
        switch (c) {
            case '{': case '[':
                count++;
                if (tokens == NULL) break;
                tok = jsmndr_alloc_token(parser, tokens, num_tokens);
                if (tok == NULL) return -1;
                if (parser->toksuper != -1) {
                    tokens[parser->toksuper].size++;
                    tok->parent = parser->toksuper;
                }
                tok->type = (c == '{' ? JSON_OBJECT : JSON_ARRAY);
                tok->start = parser->pos;
                parser->toksuper = parser->toknext - 1;
                break;
            case '}': case ']':
                if (tokens == NULL) break;
                type = (c == '}' ? JSON_OBJECT : JSON_ARRAY);
                for (i = parser->toknext - 1; i >= 0; i--) {
                    tok = &tokens[i];
                    if (tok->start != -1 && tok->end == -1) {
                        if (tok->type != type) return -2;
                        tok->end = parser->pos + 1;
                        parser->toksuper = tok->parent;
                        break;
                    }
                }
                break;
            case '"':
                parser->pos++;
                start = parser->pos;
                for (; parser->pos < len && js[parser->pos] != '\0'; parser->pos++) {
                    if (js[parser->pos] == '\\') { parser->pos++; continue; }
                    if (js[parser->pos] == '"') break;
                }
                if (tokens == NULL) break;
                tok = jsmndr_alloc_token(parser, tokens, num_tokens);
                if (tok == NULL) return -1;
                jsmndr_fill_token(tok, JSON_STRING, start, parser->pos);
                if (parser->toksuper != -1) tokens[parser->toksuper].size++;
                break;
            case '\t': case '\r': case '\n': case ' ': case ',': case ':':
                break;
            default:
                /* Primitive: number, true, false, or null - runs until a
                   structural/whitespace delimiter. Reuses the func-local
                   'start'/'c' from the string-token case above. */
                start = parser->pos;
                for (; parser->pos < len && js[parser->pos] != '\0'; parser->pos++) {
                    c = js[parser->pos];
                    if (c == '\t' || c == '\r' || c == '\n' || c == ' ' ||
                        c == ',' || c == ']' || c == '}' || c == ':') {
                        break;
                    }
                }
                if (tokens != NULL) {
                    tok = jsmndr_alloc_token(parser, tokens, num_tokens);
                    if (tok == NULL) return -1;
                    jsmndr_fill_token(tok, JSON_PRIMITIVE, start, parser->pos);
                    if (parser->toksuper != -1) tokens[parser->toksuper].size++;
                }
                parser->pos--; /* outer for-loop's pos++ lands back on the delimiter */
                break;
        }
    }
    /* count only tallies '{'/'[' opens, not string/primitive tokens - it
       undercounts real usage. When actually filling tokens (the only mode
       this codebase uses), parser->toknext is the true number of tokens
       written and is what callers need to know how far to iterate. Keep
       returning count for the tokens==NULL dry-run case to preserve its
       original (still partial) counting behavior. */
    return tokens != NULL ? (int)parser->toknext : count;
}

qboolean JSON_ValueEquals(const char *json, jsmndrtok_t *tok, const char *s) {
    if (tok->type == JSON_STRING && (int)strlen(s) == tok->end - tok->start &&
        Q_strncmp(json + tok->start, s, tok->end - tok->start) == 0) {
        return qtrue;
    }
    return qfalse;
}

int JSON_FindKey(const char *json, jsmndrtok_t *tokens, int num_tokens, int obj_tok_idx, const char *key) {
    int i;
    if (tokens[obj_tok_idx].type != JSON_OBJECT) return -1;
    for (i = obj_tok_idx + 1; i < num_tokens; i++) {
        if (tokens[i].parent == obj_tok_idx) {
            if (JSON_ValueEquals(json, &tokens[i], key)) {
                return i + 1; /* Next token is the value */
            }
        }
    }
    return -1;
}
