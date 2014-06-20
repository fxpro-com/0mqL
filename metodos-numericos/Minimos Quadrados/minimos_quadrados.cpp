//+------------------------------------------------------------------+
//|                                               minimos_quadrados  |
//|                         Copyright © 2012, Cleiton da Silva Gomes |
//|                                   http://www.softwarecsg.com.br  |
//+------------------------------------------------------------------+

#include <stdio.h>
#include <stdlib.h>
#define LACOS 700

int main(){
    system("color F2");
    FILE *arquivo;
    double x[LACOS], y[LACOS];
    double soma_x = 0, soma_y = 0;
    double numerador, denominador;
    int i;
    
    arquivo = fopen("dados.txt","rt");
    
    for(i = 1; i < LACOS; i++){
          fscanf(arquivo, "%lf",&x[i]);
          fscanf(arquivo, "%lf",&y[i]);
          
          printf("%lf\n\n",x[i]);
    
           soma_x = soma_x + x[i];
           soma_y = soma_y + y[i];
          
    }
    
    for(i = 1; i < LACOS; i++){
          numerador = x[i]*(y[i] - soma_x/LACOS);
          denominador = y[i]*(x[i] - soma_y/LACOS);
          
    }
    
    double b = numerador/denominador;
    double a = soma_y/LACOS - (b*soma_x/LACOS);
    
    printf("\t\t_-___-__-__-__-__-__-__-__-__-_-__-_-__-_-__-_\n");
    printf("\t\t\tEquacao geral pelo metodo de minimos quadrados\n");
    printf(" \t\t\tY = %lf X + (%lf)\n", a, b);
    printf("\t\t_-___-__-__-__-__-__-__-__-__-_-__-_-__-_-__-_\n");
    
    
   system("pause"); 
   return 0;
}
