#property copyright "Copyright 2014,  Cleiton Gomes"
#property link      "cleitoncsg@gmail.com"

#define CONVERTE_PONTOS 100000
#define TAKE_PROFIT 250
#define STOP_LOSS 250
#define ALAVANCAGEM 0.01

int ticket=0;
string nome = "CSG";

int start(){
   bool Abresell, Abrebuy;
   double correlacao;
   
   int arquivo = FileOpen("correlacao.txt", FILE_CSV|FILE_READ, ';');
   FileReadDouble(arquivo, correlacao  = DOUBLE_VALUE);
   FileClose(arquivo);
   
   correlacao = correlacao/10;
   
   //Condição para não entrar na sexta-feira
   if( DayOfWeek() != 5 ){
      //Condições para ativar a compra ou venda
      if( correlacao > 0.7 ){
         Abresell = true; 
      }
      if( correlacao < 0 && correlacao > -0.7 ){
         Abrebuy = true;
      }
   }
  
   if( ((Abrebuy == true  && OrdersTotal() == 0)) ){
      RefreshRates();
      while (IsTradeContextBusy()) Sleep(5);
      ticket= OrderSend(Symbol(),OP_BUY,ALAVANCAGEM,Ask,0,Ask - TAKE_PROFIT*Point,
      Ask + TAKE_PROFIT*Point,nome,AccountNumber(),0,Yellow);
      
   }
   if( ((Abresell == true && OrdersTotal() == 0)) ){
      RefreshRates();
      while (IsTradeContextBusy()) Sleep(5);
      ticket= OrderSend(Symbol(),OP_SELL,ALAVANCAGEM,Bid,0,Bid + STOP_LOSS*Point,
      Bid - TAKE_PROFIT*Point,nome,AccountNumber(),0,Green); 
   }
   
	double ponto_positivo, ponto_negativo;

   //Laço para saber a quantidade de ordens em lucro ou em prejuizo
	for(int j=0; j < OrdersHistoryTotal();j++){
		   if(OrderSymbol()!=Symbol()) continue;
		   if(OrderMagicNumber() != AccountNumber()) continue;
		   if(OrderProfit() > 0){
		       ponto_positivo++; 
		   }
		   else{ 
		      ponto_negativo++;
		   }
	}
   
   //_-_-_ Apresentação na Tela
   Comment(
       "Margem da Conta = ", AccountMargin() ,"\n",
       "Ordens em lucro = ", ponto_positivo ,"\n",
       "Ordens em prejuizo = ", ponto_negativo ,"\n",
       "STOP LOSS = ", STOP_LOSS ,"\n",
       "TAKE PROFIT = ", TAKE_PROFIT ,"\n",
       "CORRELAÇÃO LINEAR ", correlacao ,"\n",
       //"PORCENTAGEM DE ACERTO = [ ", (ponto_positivo/(ponto_negativo + ponto_positivo))*100 ," %]\n",
      
      ""
   );
    
   return(0);
}

 