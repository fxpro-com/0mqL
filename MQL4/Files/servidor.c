#include <zmq.h>
#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <assert.h>
#include <string.h>

#define TAMANHO_STRING 50

int main (void){
    FILE *arquivoCorrelacao, *arquivoFibonacci, *arquivoMediaMovel;
    char correlacao[TAMANHO_STRING], fibonacci[TAMANHO_STRING], 
         mediaMovel[TAMANHO_STRING], conteudoCliente [TAMANHO_STRING];
    void *contexto, *resposta
    int conexao;

    *contexto = zmq_ctx_new ();
    *resposta = zmq_socket (contexto, ZMQ_REP);
    conexao = zmq_bind (resposta, "tcp://*:5555");

    assert (conexao == 0);

    while (1) {
    	arquivoCorrelacao = fopen("correlacao.txt","rt");
    	fscanf(arquivoCorrelacao, "%s",correlacao);

        arquivoFibonacci = fopen("fibonacci.txt","rt");
    	fscanf(arquivoFibonacci, "%s",fibonacci);

        arquivoMediaMovel = fopen("mediaMovel.txt","rt");
    	fscanf(arquivoMediaMovel, "%s",mediaMovel);

        zmq_recv (resposta, conteudoCliente, TAMANHO_STRING, 0);

    	if(strcmp(conteudoCliente, "robo1") == 0){
        	strcat(correlacao, " ");
        	strcat(correlacao, fibonacci);
        	strcat(correlacao, " ");
        	strcat(correlacao, mediaMovel);
    		zmq_send (resposta, correlacao,TAMANHO_STRING, 0);
    		printf("Requisicao do robo 1: %s\n",conteudoCliente);
    	}
    	if(strcmp(conteudoCliente, "robo2") == 0){
        	strcat(correlacao, " ");
        	strcat(correlacao, fibonacci);
    		zmq_send (resposta, correlacao , TAMANHO_STRING, 0);
    		printf("requisicao do robo: %s\n",conteudoCliente);
    	}
        if(strcmp(conteudoCliente, "robo3") == 0){
    		zmq_send (resposta, correlacao , TAMANHO_STRING, 0);
    		printf("requisicao do robo: %s\n",conteudoCliente);
    	}
        else
            printf("Requisicao nao encontrada!\n");
        
        sleep(10);

    	fclose(arquivoCorrelacao);
    	fclose(arquivoFibonacci);
    	fclose(arquivoMediaMovel);
    }

    return 0;
}
