#include <zmq.h>
#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <assert.h>
#include <string.h>

#define TAMANHO 15

int main (void){
    void *context = zmq_ctx_new ();
    void *responder = zmq_socket (context, ZMQ_REP);
    FILE *arquivo;
    int rc = zmq_bind (responder, "tcp://*:5555");
    char correlacao[TAMANHO];

    assert (rc == 0);

    while (1) {
    	arquivo = fopen("correlacao.txt","rt");
    	fscanf(arquivo, "%s",correlacao);

        char buffer [TAMANHO];
        zmq_recv (responder, buffer, TAMANHO, 0);

    	if(strcmp(buffer, "robo1") == 0){
    		zmq_send (responder, correlacao, 5, 0);
    		printf("%s\n",buffer);
    	}
    	if(strcmp(buffer, "robo2") == 0){
    		zmq_send (responder, "correlacao" , 5, 0);
    		printf("%s\n",buffer);
    	}
        zmq_send (responder, correlacao, 5, 0);
        sleep(10);

	    fclose(arquivo);
    }

    return 0;
}
