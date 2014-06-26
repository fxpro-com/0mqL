#property copyright "Copyright 2014,  Cleiton Gomes"
#property link      "cleitoncsg@gmail.com"

int Tempo_correlacao = 34;


int start(){
   int arquivo = FileOpen("correlacao.txt", FILE_CSV|FILE_WRITE, ';');
   FileWrite(arquivo, correlacao_pearson());
   FileClose(arquivo);
   
   //_-_-_ Apresentação na Tela
   Comment(
       "CORRELAÇÃO LINEAR ", correlacao_pearson() ,"\n",
      ""
   );
    
   return(0);
}

double correlacao_pearson(){
	     int c =0;
	     double soma_ordenadas = 0;
	     double soma_abcissas = 0;
	     double soma_ordenadas_quadrado = 0;
	     double soma_abcissas_quadrado = 0;
	     double numero_abcissa;
	     double numero_ordenada;
	     double soma_X_vezes_Y = 0;
	     double numerador, denominador_1,denominador,correlacao;
	
        for(c=0; c<Tempo_correlacao; c++){
           numero_abcissa = NormalizeDouble(Open[c],5);
           numero_ordenada =NormalizeDouble(Close[c],5);    
		     soma_abcissas = soma_abcissas + numero_abcissa;
		     soma_abcissas_quadrado = (soma_abcissas_quadrado) + (numero_abcissa)*(numero_abcissa);
		     soma_ordenadas = soma_ordenadas + numero_ordenada;
		     soma_ordenadas_quadrado = (soma_ordenadas_quadrado) + (numero_ordenada)*(numero_ordenada);
		     soma_X_vezes_Y = soma_X_vezes_Y + (numero_ordenada*numero_abcissa);
	     } 
 
	     numerador =((Tempo_correlacao*soma_X_vezes_Y)-((soma_abcissas)*(soma_ordenadas)));
	     denominador_1 =((Tempo_correlacao*soma_abcissas_quadrado)-(soma_abcissas*soma_abcissas))*((Tempo_correlacao*soma_ordenadas_quadrado)-(soma_ordenadas*soma_ordenadas));	
	     denominador = MathPow(denominador_1,1.0/2.0); 

        if(denominador != 0)
            correlacao = numerador/denominador;
        else
            correlacao = 0;  
   
        return (correlacao);
}
 