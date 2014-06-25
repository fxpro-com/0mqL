//+------------------------------------------------------------------+
//|                                                   mediaMovel.mq4 |
//|                                    Copyright 2014, Cleiton Gomes |
//|                                        http://softwarecsg.com.br |
//+------------------------------------------------------------------+
#property copyright "Copyright 2014, Cleiton Gomes"
#property link      "http://softwarecsg.com.br"
#property version   "1.00"

#define MMLENTA 21
#define MMRAPIDA 34

int start(){
   int arquivo = FileOpen("mediaMovel.txt", FILE_CSV|FILE_WRITE, ';');
   FileWrite(arquivo, mediaMovelLenta());
   FileWrite(arquivo, mediaMovelRapida());
   FileClose(arquivo);
   
   //_-_-_ Apresentação na Tela
   Comment(
       "Media Movel Lenta ", mediaMovelLenta() ,"\n",
       "Media Movel Lenta ", mediaMovelRapida() ,"\n",
      ""
   );
   
   return (0);

}

double mediaMovelLenta(){
   double somaCotacoes = 0;
   
   for(int c=0; c<MMLENTA; c++){
      somaCotacoes += NormalizeDouble(Open[c],5);
   }
   
   return (somaCotacoes/MMLENTA);
}

double mediaMovelRapida(){
   double somaCotacoes = 0;
   
   for(int c=0; c<MMRAPIDA; c++){
      somaCotacoes += NormalizeDouble(Open[c],5);
   }
   
   return (somaCotacoes/MMRAPIDA);
}
