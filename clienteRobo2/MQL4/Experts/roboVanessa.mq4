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
   double fibonacci;
   
   int arquivo = FileOpen("fibonacci.txt", FILE_CSV|FILE_READ, ';');
   FileReadDouble(arquivo, fibonacci  = DOUBLE_VALUE);
   FileClose(arquivo);
   
   //Condições para ativar a compra ou venda
   if( fibonacci > 0.1 && fibonacci < 0.2 ){
      Abresell = true; 
   }
   if( fibonacci > 0.3 ){
      Abrebuy = true;
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
       "FIBONACCI ", fibonacci ,"\n",
       //"PORCENTAGEM DE ACERTO = [ ", (ponto_positivo/(ponto_negativo + ponto_positivo))*100 ," %]\n",
      
      ""
   );
    
   return(0);
}

 