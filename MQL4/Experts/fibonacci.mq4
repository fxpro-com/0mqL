//+------------------------------------------------------------------+
//|                                                       GCBM_1.mq4 |
//|                           Copyright 2014, Cleiton da Silva Gomes |
//|                                    http://www.softwarecsg.com.br |
//+------------------------------------------------------------------+
#property copyright "Copyright 2014, Cleiton da Silva Gomes"
#property link      "http://www.softwarecsg.com.br"

double suporte = 999;
double resistencia = -999;
double pontoCompra, pontoVenda;

#define VELAS 13

double retracaoFibonacci(){
   
   detectaSuporteResistencia();
   
   double fibonacci = MathAbs(suporte - resistencia);
   fibonacci = fibonacci*0.38;
   
   return (fibonacci);
}

int start(){

   int arquivo = FileOpen("fibonacci.txt", FILE_CSV|FILE_WRITE, ';');

   detectaSuporteResistencia();
   
   FileWrite(arquivo, retracaoFibonacci());
   
   Comment(
       "Fibonacci = ", retracaoFibonacci(),"\n",
      
      ""
   );
   
   FileClose(arquivo);
   
   return(0);
}

void detectaSuporteResistencia(){
    
   for(int i = 0 ; i < VELAS ; i++){
   
      if(suporte > Low[i])
         suporte = Low[i];
      if(resistencia < High[i])
         resistencia = High[i];
   }
   
   bufferSuporteResistencia();
}

void bufferSuporteResistencia(){

   int tempoDecorrido = TimeMinute(TimeCurrent());
   
   if(  tempoDecorrido == VELAS ){
      suporte = 999;
      resistencia = -999;
      pontoCompra = 0;
      pontoVenda = 0;
   }
} 