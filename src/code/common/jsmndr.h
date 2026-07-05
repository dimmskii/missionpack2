// JSON Parser
//


#ifndef JSMNDR_H
#define JSMNDR_H

#include "../game/q_shared.h"

typedef enum {
    JSON_UNDEFINED,
    JSON_OBJECT,
    JSON_ARRAY,
    JSON_STRING,
    JSON_PRIMITIVE
} jsmndrtype_t;

typedef struct {
    jsmndrtype_t type;
    int start;
    int end;
    int size;
    int parent;
} jsmndrtok_t;

typedef struct {
    unsigned int pos;
    unsigned int toknext;
    int toksuper;
} jsmndr_parser;

void jsmndr_init(jsmndr_parser *parser);
int jsmndr_parse(jsmndr_parser *parser, const char *js, size_t len, jsmndrtok_t *tokens, unsigned int num_tokens);

void jsmndr_copy_token( char *dst, int dstSize, const char *json, jsmndrtok_t *tok );

/* Utility helpers for Quake 3 */
qboolean JSON_ValueEquals(const char *json, jsmndrtok_t *tok, const char *s);
int JSON_FindKey(const char *json, jsmndrtok_t *tokens, int num_tokens, int obj_tok_idx, const char *key);

#endif

