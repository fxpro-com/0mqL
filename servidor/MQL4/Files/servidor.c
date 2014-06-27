#include <zmq.h>
#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <assert.h>
#include <string.h>

#define TAMANHO_STRING 10

int main (void){
    FILE *arquivoCorrelacao, *arquivoFibonacci, *arquivoMediaMovel;
    char correlacao[TAMANHO_STRING], fibonacci[TAMANHO_STRING], mediaMovel[TAMANHO_STRING];
    char conteudoCliente[10];
    void *contexto = zmq_ctx_new ();
    void *resposta = zmq_socket (contexto, ZMQ_REP);
    int conexao = zmq_bind (resposta, "tcp://*:5555");

    assert (conexao == 0);

    while (1) {
    	arquivoCorrelacao = fopen("correlacao.txt","rt");
    	fscanf(arquivoCorrelacao, "%s",correlacao);

	arquivoFibonacci = fopen("fibonacci.txt","rt");
    	fscanf(arquivoFibonacci, "%s",fibonacci);

	arquivoMediaMovel = fopen("mediaMovel.txt","rt");
    	fscanf(arquivoMediaMovel, "%s",mediaMovel);

        zmq_recv (resposta, conteudoCliente, 10, 0);

    	if(conteudoCliente[8] == 'o' || conteudoCliente[8] == '0'){
    		zmq_send (resposta, correlacao,TAMANHO_STRING, 0);
    		printf("%s",conteudoCliente);
    	}
    	if(conteudoCliente[8] == 'i' || conteudoCliente[8] == 'I'){
    		zmq_send (resposta, fibonacci ,TAMANHO_STRING , 0);
    		printf("%s",conteudoCliente);
    	}
	if(conteudoCliente[9] == 'l' || conteudoCliente[8] == 'L'){
    		zmq_send (resposta, mediaMovel ,TAMANHO_STRING, 0);
    		printf("%s",conteudoCliente);
    	}
	else
	       printf("Erro");

        sleep(10);

	fclose(arquivoCorrelacao);
	fclose(arquivoFibonacci);
	fclose(arquivoMediaMovel);
    }

    return 0;
}
