/*+------------------------------------------------------------------+
  |           Versão Tri_Dimensional da Correlação                   |
  |                         EL LOCO INTELIGENTE                      |
  |                                                                  |
+------------------------------------------------------------------+*/

   #property copyright "aprendiz.fga"
   #property link      "aprendiz.fga@gmail.com"
  // #include <stdlib.mqh>

   #import "stdlib.mq4"
       string ErrorDescription(int error_code);

   //================================================================================================================
   //---- input parametros
   //definição do valor da correlação 3D para se entrar no mercado
   #define CONST_CORRELACAO 1.21
   extern string    _1 ="Ants Scalper V4";
   extern double    Lotes = 0.02; //Definição da alavancagem inicial
   extern int       Spread = 5;

   extern string Signal_setup;
   extern int    MA_fast      = 12;
   extern int    MA_slow      = 26;
   extern int    Shift        = 0;
   
   int Tempo_correlacao = 34; 
   //61,127,179,181,239,241 > primos 
   //1,3,5,8,13,21,34,55,89,144,377,610,987,1587,2584,4181,6765 > fibo
   int       Tempo_Operacao  = 05;
   int Ponto_zero;
   double    fix_bid = 0;
   double    fix_ask = 0;
   double    negativo, positivo;
   string    nome = "Ants";

   //================================================================================================================
   //---- ajustes
   double pip;
   int digits;

   int init()
   {
       if (Point == 0.00001) pip = 0.0001;
       else 
	    {
	     if (Point == 0.001) pip = 0.01;
	     else pip = Point;
       }

       double lotStep = MarketInfo(Symbol(), MODE_LOTSTEP);
	
       if (lotStep >= 1) digits = 0;             // 1
       else if (lotStep * 10 >= 1) digits = 1;   // 0.1
            else digits = 2;                     // 0.01
     return(0);
   }
   
   double correlacao_tridimensional_1(){
	     int c =0;
	     double soma_ordenadas = 0;
	     double soma_abcissas = 0;
	     double soma_ordenadas_quadrado = 0;
	     double soma_abcissas_quadrado = 0;
	     double numero_abcissa;
	     double numero_ordenada;
	     double soma_X_vezes_Y = 0;
	     double numerador, denominador_1,denominador,correlacao;
	
     //---Calculo das Somatorias  
        for(c=0; c<Tempo_correlacao; c++){
           numero_abcissa = NormalizeDouble(Open[c],5);
           numero_ordenada =NormalizeDouble(Close[c],5);    
		     soma_abcissas = soma_abcissas + numero_abcissa;
		     soma_abcissas_quadrado = (soma_abcissas_quadrado) + (numero_abcissa)*(numero_abcissa);
		     soma_ordenadas = soma_ordenadas + numero_ordenada;
		     soma_ordenadas_quadrado = (soma_ordenadas_quadrado) + (numero_ordenada)*(numero_ordenada);
		     soma_X_vezes_Y = soma_X_vezes_Y + (numero_ordenada*numero_abcissa);
	     } 
     //---Calculo da expressao
	
	     numerador =((Tempo_correlacao*soma_X_vezes_Y)-((soma_abcissas)*(soma_ordenadas)));
	     denominador_1 =((Tempo_correlacao*soma_abcissas_quadrado)-(soma_abcissas*soma_abcissas))*((Tempo_correlacao*soma_ordenadas_quadrado)-(soma_ordenadas*soma_ordenadas));	
	     denominador = MathPow(denominador_1,1.0/2.0); 
	
     //---Calculo do valor final
        correlacao = numerador/denominador;  
   
        return (correlacao);
        
   
   }
   
   double correlacao_tridimensional_2(){
	     int c =0;
	     double soma_ordenadas = 0;
	     double soma_abcissas = 0;
	     double soma_ordenadas_quadrado = 0;
	     double soma_abcissas_quadrado = 0;
	     double numero_abcissa;
	     double numero_ordenada;
	     double soma_X_vezes_Y = 0;
	     double numerador, denominador_1,denominador,correlacao;
	
     //---Calculo das Somatorias  
        for(c=0; c<Tempo_correlacao; c++){
           numero_abcissa = NormalizeDouble(Low[c],5);
           numero_ordenada =NormalizeDouble(High[c],5);    
		     soma_abcissas = soma_abcissas + numero_abcissa;
		     soma_abcissas_quadrado = (soma_abcissas_quadrado) + (numero_abcissa)*(numero_abcissa);
		     soma_ordenadas = soma_ordenadas + numero_ordenada;
		     soma_ordenadas_quadrado = (soma_ordenadas_quadrado) + (numero_ordenada)*(numero_ordenada);
		     soma_X_vezes_Y = soma_X_vezes_Y + (numero_ordenada*numero_abcissa);
	     } 
     //---Calculo da expressao
	
	     numerador =((Tempo_correlacao*soma_X_vezes_Y)-((soma_abcissas)*(soma_ordenadas)));
	     denominador_1 =((Tempo_correlacao*soma_abcissas_quadrado)-(soma_abcissas*soma_abcissas))*((Tempo_correlacao*soma_ordenadas_quadrado)-(soma_ordenadas*soma_ordenadas));	
	     denominador = MathPow(denominador_1,1.0/2.0); 
	
     //---Calculo do valor final
        correlacao = numerador/denominador;  
   
        return (correlacao);
        
   
   }
   
   double correlacao_tridimensional_3(){
	     int c =0;
	     double soma_ordenadas = 0;
	     double soma_abcissas = 0;
	     double soma_ordenadas_quadrado = 0;
	     double soma_abcissas_quadrado = 0;
	     double numero_abcissa;
	     double numero_ordenada;
	     double soma_X_vezes_Y = 0;
	     double numerador, denominador_1,denominador,correlacao;
	
     //---Calculo das Somatorias  
        for(c=0; c<Tempo_correlacao; c++){
           numero_abcissa = NormalizeDouble(Volume[c],5);
           numero_ordenada =NormalizeDouble(Volume[c+1],5);    
		     soma_abcissas = soma_abcissas + numero_abcissa;
		     soma_abcissas_quadrado = (soma_abcissas_quadrado) + (numero_abcissa)*(numero_abcissa);
		     soma_ordenadas = soma_ordenadas + numero_ordenada;
		     soma_ordenadas_quadrado = (soma_ordenadas_quadrado) + (numero_ordenada)*(numero_ordenada);
		     soma_X_vezes_Y = soma_X_vezes_Y + (numero_ordenada*numero_abcissa);
	     } 
     //---Calculo da expressao
	
	     numerador =((Tempo_correlacao*soma_X_vezes_Y)-((soma_abcissas)*(soma_ordenadas)));
	     denominador_1 =((Tempo_correlacao*soma_abcissas_quadrado)-(soma_abcissas*soma_abcissas))*((Tempo_correlacao*soma_ordenadas_quadrado)-(soma_ordenadas*soma_ordenadas));	
	     denominador = MathPow(denominador_1,1.0/2.0); 
	
     //---Calculo do valor final
        correlacao = numerador/denominador;  
   
        return (correlacao);
           
   }

   //=====================================================================================
	   int start() 
	   {
	   int CHAVE;
	   bool Abrebuy, Abresell;
	   int arquivo;
      arquivo = FileOpen("CHAVE_1.txt", FILE_CSV|FILE_WRITE, ';');

	   if(nome != "Ants") nome = "Ants";

	   //---- Estratégia
	   HideTestIndicators(TRUE);
	   RefreshRates();
	   double Stc =    iStochastic(NULL,Tempo_Operacao,5,3,3,MODE_SMA,0,MODE_MAIN,1);
	   double Signal = iStochastic(NULL,Tempo_Operacao,5,3,3,MODE_SMA,0,MODE_SIGNAL,1);

	   //---------------

	   double MaFastCurrent=iMA(NULL,Tempo_Operacao,MA_fast,0,MODE_EMA,PRICE_CLOSE,Shift+0);
	   double MaFastPrevious=iMA(NULL,Tempo_Operacao,MA_fast,0,MODE_EMA,PRICE_CLOSE,Shift+1);
	   double MaSlowCurrent=iMA(NULL,Tempo_Operacao,MA_slow,0,MODE_EMA,PRICE_CLOSE,Shift+0);
	   double MaSlowPrevious=iMA(NULL,Tempo_Operacao,MA_slow,0,MODE_EMA,PRICE_CLOSE,Shift+1);
	   //----------------

	   HideTestIndicators(FALSE);
	   double realizaoperacao = true;
	   //Condição para a realização da operação ser falsa
	   if ((Stc > Signal && MaFastCurrent<MaSlowCurrent) || (Stc < Signal && MaFastCurrent>MaSlowCurrent)){
	      Ponto_zero++; 
		   realizaoperacao = false;
		}

      /*Calculando a correlaçao 3D através das funções correlacao_tridimensional_1()
      correlacao_tridimensional_2() e correlacao_tridimensional_3()*/
      double correlacao_3D_pre = MathPow(correlacao_tridimensional_1(), 2.0/1.0) + MathPow(correlacao_tridimensional_2(), 2.0/1.0) + 
      MathPow(correlacao_tridimensional_3(), 2.0/1.0);
      double correlacao_3D = MathPow (correlacao_3D_pre, 1.0/2.0);
      
      //Condicionando a correlação como criterio para entrar no mercado
      if(correlacao_3D >= CONST_CORRELACAO && DayOfWeek() != 5){
	     if(Stc > Signal){ Abrebuy  = true; }
	     if(Stc < Signal){ Abresell = true; }
    
        if( Abrebuy == true || Abresell == true){
         CHAVE = 1;
         FileWrite(arquivo, CHAVE);
         FileClose(arquivo);
        }
        
	   }
	   
	  
	   
	   //=====================================================================================
	   //---- Abrir Ordem
	   bool Fora = false;
	   int cnt, erro, res;
	   int totalbuy, totalsell;
	   double total = 0;
	   double Lp = 0, Lote;
	   double Lp_buy, Lp_sell;
	   

	   for(cnt=0;cnt<OrdersTotal();cnt++)
	   {
		   //OrderSelect(cnt, SELECT_BY_POS, MODE_TRADES);
		   if(OrderSymbol() != Symbol()) continue;
		   if(OrderMagicNumber() != AccountNumber())  continue;
		   if(OrderType() == OP_BUY)  {totalbuy++;  Lp_buy  += OrderLots();}
		   if(OrderType() == OP_SELL) {totalsell++; Lp_sell += OrderLots();}
		   total += OrderProfit()+OrderSwap();
		   if(OrderComment() != "Ants") continue;
		   if(OrderLots() > Lp) Lp = OrderLots();
	   }

	   if (Lp > 0){
	       Lote = 2 * Lp;
	       //Se o robo não estiver no mercado
	       CHAVE = 1;
          FileWrite(arquivo, "%d", CHAVE);
          FileClose(arquivo);
      }
	   else Lote = Lotes;
		
		//Condição para saber se tem dinheiro para ficar no mercado
	   if(Lp == 0 && AccountMargin()/AccountBalance() < 0.3)
	   {
	      Fora = true;
	      fix_bid = 0;
	      fix_ask = 0;
	   }

      //Cálculo do suporte e da resistencia
	   double Suporte     = Bid - 100 * pip * MarketInfo(Symbol(),MODE_STOPLEVEL);
	   double Resistencia = Ask + 100 * pip * MarketInfo(Symbol(),MODE_STOPLEVEL);

	   if(Lp > 0)
	   {
	      for(cnt=0;cnt<OrdersTotal();cnt++)
	      {
		      //OrderSelect(cnt, SELECT_BY_POS, MODE_TRADES);
		      if(OrderSymbol() != Symbol()) continue;
		      if(OrderMagicNumber() != AccountNumber()) continue;
		      if(OrderLots() != Lp) continue;
		      if(Abrebuy  && totalbuy  < 3 && OrderOpenPrice() - Bid >= pip * MarketInfo(Symbol(),MODE_STOPLEVEL) && total < 0)Fora = true;
		      if(Abrebuy && totalbuy == 3 && totalsell == 3 && OrderOpenPrice() - Bid >= pip * MarketInfo(Symbol(),MODE_STOPLEVEL) && total < 0){
			     Fora = true;
			     Abrebuy = false;
			     Abresell = true;
			     Lote = MathAbs(Lp_buy - Lp_sell);
			     nome = "Trava";
			     Resistencia = Ask+MarketInfo(Symbol(),MODE_STOPLEVEL)*Point;
			     break;}       
		      if(Abresell && totalsell < 3 && Ask - OrderOpenPrice() >= pip * MarketInfo(Symbol(),MODE_STOPLEVEL) && total < 0)Fora = true;
		      if(Abresell && totalbuy == 3 && totalsell == 3 && Ask - OrderOpenPrice() >= pip * MarketInfo(Symbol(),MODE_STOPLEVEL) && total < 0){
			     Fora = true;
			     Abrebuy = true;
			     Abresell = false;
			     Lote = MathAbs(Lp_buy - Lp_sell);
			     nome = "Trava";
			     Suporte = Bid-MarketInfo(Symbol(),MODE_STOPLEVEL)*Point; 
			     break;}
     
		       if(Abrebuy  && totalbuy  < 1 && OrderType() == OP_SELL && total < 0) {Fora = true; Lote *= 2;}
		       if(Abresell && totalsell < 1 && OrderType() == OP_BUY  && total < 0) {Fora = true; Lote *= 2;}
		      break;
	      }
	   }


	   Lote = NormalizeDouble(Lote, digits);
	   
	   if(Abrebuy && Fora && (Suporte > 0)&& realizaoperacao)
	   {
	      RefreshRates();
	      while (IsTradeContextBusy()) Sleep(5);
	      res  = OrderSend(Symbol(),OP_BUY,Lote,Ask,3,Suporte,0,nome,AccountNumber(),0,Yellow);
	      erro = GetLastError();
	      if (res < 0) Print("Erro ao abrir operação Buy - erro (",erro, "): ", ErrorDescription(erro));
	   }


	   if(Abresell && Fora && (Resistencia > 0)&& realizaoperacao)
	   {
	      RefreshRates();
	      while (IsTradeContextBusy()) Sleep(5);
	      res  = OrderSend(Symbol(),OP_SELL,Lote,Bid,3,Resistencia,0,nome,AccountNumber(),0,Blue);
	      erro = GetLastError();
	      if (res < 0) Print("Erro ao abrir operação Sell - erro (",erro, "): ", ErrorDescription(erro));

	   }

	   //=====================================================================================
	   //---- Deslocar Estope
	   bool sobe, desce;
	   Lp = 0;
	   total = 0;

	   for(cnt=0;cnt<OrdersTotal();cnt++)
	   {
		   //OrderSelect(cnt, SELECT_BY_POS, MODE_TRADES);
		   if(OrderSymbol() != Symbol()) continue;
		   if(OrderMagicNumber() != AccountNumber()) continue;
		   total += OrderProfit()+OrderSwap();
		   if(OrderComment() != "Ants") continue;
		   if(OrderLots() > Lp)
		   {
		      Lp = OrderLots();
		      if(OrderType() == OP_BUY)
		      {
			     sobe  = true;
			     desce = false;
		      }
		      else
			   {
			     sobe  = false;
			     desce = true;
		      }
		   }
	   }

	   if(total > 0 && fix_bid == 0)
	   {
	      fix_bid = Bid;
	      fix_ask = Ask;
	   }

	   if(total < 0 && fix_bid != 0)
	   {
	      fix_bid = 0;
	      fix_ask = 0;
	   }

	   if(sobe && Bid-MarketInfo(Symbol(),MODE_STOPLEVEL)*Point > fix_bid && fix_bid != 0)
	   {
	      for(cnt=0;cnt<OrdersTotal();cnt++)
	      {
		      //OrderSelect(cnt, SELECT_BY_POS, MODE_TRADES);
		      if(OrderSymbol() != Symbol()) continue;
		      if(OrderMagicNumber() != AccountNumber()) continue;
		      if(OrderType() == OP_SELL)
		      {
			     RefreshRates();
			     while (IsTradeContextBusy()) Sleep(5);
			     res  = OrderClose(OrderTicket(),OrderLots(),Ask,10,Black);
			     erro = GetLastError();
			     if (res < 0) Print("Erro ao fechar operação Sell - erro (",erro , "): ", ErrorDescription(erro));
			      if(OrderStopLoss() > Ask)
			       {
				    RefreshRates();
				    while (IsTradeContextBusy()) Sleep(5);
				    res  = OrderModify(OrderTicket(),OrderOpenPrice(),Ask,OrderTakeProfit(),0,Red);
				    erro = GetLastError();
				    if (res < 0) Print("Erro ao deslocar Stop operação Sell - erro (", erro, "): ", ErrorDescription(erro));
			       }
		      }
		      else if(OrderStopLoss() < Bid - MarketInfo(Symbol(),MODE_STOPLEVEL)*Point)
		      {
			     RefreshRates();
			     while (IsTradeContextBusy()) Sleep(5);
			     res  = OrderModify(OrderTicket(),OrderOpenPrice(),Bid - MarketInfo(Symbol(),MODE_STOPLEVEL)*Point,OrderTakeProfit(),0,Red);
			     erro = GetLastError();
			     if (res < 0) Print("Erro ao deslocar Stop operação Buy - erro (", erro, "): ", ErrorDescription(erro));
		      }
	      }
	   }

	   if(desce && Ask+MarketInfo(Symbol(),MODE_STOPLEVEL)*Point < fix_ask && fix_ask != 0){
	      for(cnt=0;cnt<OrdersTotal();cnt++){
		      //OrderSelect(cnt, SELECT_BY_POS, MODE_TRADES);
		      if(OrderSymbol() != Symbol()) continue;
		      if(OrderMagicNumber() != AccountNumber())  continue;
		      if(OrderType() == OP_BUY){
			     RefreshRates();
			     while (IsTradeContextBusy()) Sleep(5);
			     res  = OrderClose(OrderTicket(),OrderLots(),Bid,10,Black);
			     erro = GetLastError();
			     if (res < 0) Print("Erro ao fechar operação Buy - erro (",erro , "): ", ErrorDescription(erro));
			     if(OrderStopLoss() < Bid){
				    RefreshRates();
				    while (IsTradeContextBusy()) Sleep(5);
				    res  = OrderModify(OrderTicket(),OrderOpenPrice(),Bid,OrderTakeProfit(),0,Red);
				    erro = GetLastError();
				    if (res < 0) Print("Erro ao deslocar Stop operação Buy - erro (", erro, "): ", ErrorDescription(erro));
			     }
		      }
		      else if(OrderStopLoss() > Ask + MarketInfo(Symbol(),MODE_STOPLEVEL)*Point){
			     RefreshRates();
			     while (IsTradeContextBusy()) Sleep(5);
			     res  = OrderModify(OrderTicket(),OrderOpenPrice(),Ask + MarketInfo(Symbol(),MODE_STOPLEVEL)*Point,OrderTakeProfit(),0,Red);
			     erro = GetLastError();
			     if (res < 0) Print("Erro ao deslocar Stop operação Sell - erro (", erro, "): ", ErrorDescription(erro));
			   }
	      }
	   }

	   //=====================================================================================
	   //---- Apresentação na Tela
	   double Ponto_positivo, Ponto_negativo, Ponto_aberto;
	   double Positivo, Negativo, Aberto;

	   for(cnt=0;cnt<OrdersHistoryTotal();cnt++){
		   //OrderSelect(cnt,SELECT_BY_POS,MODE_HISTORY);
		   if(OrderSymbol()!=Symbol()) continue;
		   if(OrderMagicNumber() != AccountNumber()) continue;
		   if(OrderProfit()==0){Ponto_zero++; continue;}
		   if(OrderProfit() >0){Positivo+= OrderProfit()+OrderSwap(); Ponto_positivo++;}
		   else {Negativo+= MathAbs(OrderProfit()+OrderSwap());       Ponto_negativo++;}
		}
			
	   for(cnt=0;cnt<OrdersTotal();cnt++){
		   //OrderSelect(cnt, SELECT_BY_POS, MODE_TRADES);
		   if(OrderProfit()==0)          continue;
		   if(OrderSymbol()!=Symbol())   continue;
		   if(OrderMagicNumber() != AccountNumber())  continue;
		   if(OrderType()<=OP_SELL){Aberto+= OrderProfit()+OrderSwap(); Ponto_aberto++;}
		}
		
		//Condições para saber se o saldo está positivo ou negativo
	   if(Aberto > positivo) positivo = Aberto;
	   if(Aberto < negativo) negativo = Aberto;

      //Comentários a serem exibidos na tela 

	   Comment("=================================","\n",
			  // "Conta ",AccountNumber(), " - Alavancagem 1/",AccountLeverage(),"\n",
			  // "Spread ",(Ask-Bid)/pip," Pips - Spread Máximo ",Spread," Pips \n",
			  // "Hora Operação ",TimeToStr(TimeCurrent(),TIME_DATE|TIME_SECONDS),"\n",
			  // "Versão ",_1,"\n",
			   "=================================","\n",
			   "CORRELACAO 3D:  [ ", correlacao_3D ,"]\n",
			   "CHAVE:  [ ", CHAVE  ,"]\n",
			   "PORCENTAGEM DE ACERTOS:  [  ", (Ponto_positivo/(Ponto_negativo+Ponto_positivo))*100 ," %]\n",
			 "Total de Operações + ",Ponto_positivo ,"\n",
			 "Total de Operações - ",Ponto_negativo ,"\n",
	        // "Total de Ordens Abertas ",Ponto_aberto,"\n",
			   "=================================","\n",
			  // "STC-Signal = ",Stc,"  |   ", Signal,"\n",
			  // "F0-S0; F1-S1 = ",MaFastCurrent," |  ",MaSlowCurrent,"   |||    ",MaFastPrevious," | ",MaSlowPrevious,"\n",
			 //  "Saldo em U$ Aberto   ",Aberto  ,"\n",
			   "Saldo em U$ Positivo ",Positivo,"\n",
			  // "Saldo em U$ Negativo ",Negativo,"\n",
			 //  "Saldo em U$ Total    ",Positivo - Negativo,"\n",
			   "=================================","\n",
			  // "Maior valor = ", positivo,"\n",
			   "Menor  valor = ", negativo );
			
		
	   return(0);
   }
	   //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

