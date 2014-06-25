#include <zmq.h>
#include <string.h>
#include <stdio.h>
#include <unistd.h>

int main (void){
    void *contexto = zmq_ctx_new ();
    void *requisicao = zmq_socket (context, ZMQ_REQ);
    char conteudoServidor[10];

    zmq_connect (requisicao, "tcp://localhost:5555");
    printf ("Conectando com o servidor...\n");

    for (;;) {
        zmq_send (requisicao, "Ola", 5, 0);
        zmq_recv (requisicao, contexto, 10, 0);
    }
    
    zmq_close (requisicao);
    zmq_ctx_destroy (contexto);
    return 0;
}
