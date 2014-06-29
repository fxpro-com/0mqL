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

	printf("Aguardando conexao\n");

        zmq_recv (resposta, conteudoCliente, 10, 0);
	
	printf("Conexao estabelecida\n");

    	if(conteudoCliente[0] == 'c' || conteudoCliente[0] == 'C'){
    		zmq_send (resposta, correlacao,TAMANHO_STRING, 0);
    		printf("%s\n",conteudoCliente);
    	}
    	else if(conteudoCliente[0] == 'f' || conteudoCliente[0] == 'F'){
    		zmq_send (resposta, fibonacci ,TAMANHO_STRING , 0);
    		printf("%s\n",conteudoCliente);
    	}
	else if(conteudoCliente[0] == 'm' || conteudoCliente[0] == 'M'){
    		zmq_send (resposta, mediaMovel ,TAMANHO_STRING, 0);
    		printf("%s\n",conteudoCliente);
    	}
	else{
	       printf("Erro");
	       printf("%s\n",conteudoCliente);
	}

        sleep(1);

	fclose(arquivoCorrelacao);
	fclose(arquivoFibonacci);
	fclose(arquivoMediaMovel);
    }

    return 0;
}
