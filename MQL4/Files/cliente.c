#include <zmq.h>
#include <string.h>
#include <stdio.h>
#include <unistd.h>

int main (void){
    void *context = zmq_ctx_new ();
    void *requester = zmq_socket (context, ZMQ_REQ);
    char buffer [10];

    zmq_connect (requester, "tcp://localhost:5555");
    printf ("Conectando com o servidor...\n");

    for (;;) {
        zmq_send (requester, "Ola", 5, 0);
        zmq_recv (requester, buffer, 10, 0);
        printf ("Recebendo o dado %d\n", request_nbr);
    }
    
    zmq_close (requester);
    zmq_ctx_destroy (context);
    return 0;
}
