#include <zmq.h>
#include <string.h>
#include <stdio.h>
#include <unistd.h>
#define TAMANHO_STRING 50

int main (void){
    void *contexto = zmq_ctx_new ();
    void *requisicao = zmq_socket (context, ZMQ_REQ);
    char conteudoServidor[TAMANHO_STRING];

    zmq_connect (requisicao, "tcp://localhost:5555");
    printf ("Conectando com o servidor...\n");

    for (;;) {
        zmq_send (requisicao, "robo1", TAMANHO_STRING, 0);
        zmq_recv (requisicao, contexto, TAMANHO_STRING, 0);
    }
    
    zmq_close (requisicao);
    zmq_ctx_destroy (contexto);
    return 0;
}
