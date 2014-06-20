
#include<stdio.h>
#include<stdlib.h>
#include<conio.h>
#include<math.h>

// função que realiza as operações de produto entre a[l][j] e x[k][j]
double Ps ( double a[][100], double x[][100], int k1, int l, int dimensao){   
      
    double sub=0.0;
    int j1;
    
    for(j1=0;j1<dimensao;j1++){
    
        if(l==j1)
                j1++;
                
        if(j1>=dimensao)
                break;
        
        if(l>j1)
               sub= -a[l][j1]*x[k1][j1] + sub;
        else
               sub= -a[l][j1]*x[k1-1][j1] + sub;
    
    }

    return sub;
}

// função que calcula o erro relativo 'dr' entre dois vetores solução de iterações 'k' e 'k-1'
double Dr (double x[][100], int k2, int dimensao){    
    int i2;
    double m1,m2,d,dr;

    for(i2=dimensao;i2>=1;i2--){ // Laço que encontra as maiores componentes em cada vetor
         if(x[k2-1][i2]>x[k2-1][i2-1])
                              m1=x[k2-1][i2];
         else
                              m1=x[k2-1][i2-1];
        
         if(x[k2][i2]>x[k2][i2-1])
                              m2=x[k2][i2];
         else
                              m2=x[k2][i2-1];

     }
     
    d=m2-m1;
       if(d<0)
          d=-1*d;
       if(m2<0)
           m2=-1*m2;
           
    dr=d/m2;

return dr;
}

//Prototipo do procedimento contagem()
void contagem();
//Prototipo o procedimento cabecalho()
void cabecalho();

//Função principal
main(){
     //Variáveis locais
    double a[100][100],x[50][100],b[100]; // a = matriz a ser obtida de 'entrada.txt | x = matriz que contém os Xk vetores das k iterações, cada linha é uma iteração | b = vetor solução das eq. lineares
    double ps2,d,dr=100,erro;  // d = modulo da dif. das maiores componentes de um vetor Xk e Xk-1 | dr = d/(max|Xk|) | erro = dr deve ser menor que este, que é obtido de 'entrada.txt'
 
    int dimensao;
    int k;
    int i3,j3,k3=1; // indices das matrizes e vetores
    FILE *fp;    // ponteiro de arquivo 1
    FILE *fp2;    // ponteiro de arquivo 2

    cabecalho();
    
    fp = fopen("entrada.txt","r"); //  abre o arquivo 'entrada.txt' no modo apenas para leitura
     fscanf(fp,"%d",&dimensao); 
    fscanf(fp,"%lf",&erro);    // obtem o erro, do arquivo .txt

    printf("\n_________________________________________________________\n");
    printf("\nDimensao da matriz lida o arquivo =  %d",dimensao);
    printf("\nPressione qualquer tecla para gerar os resultados\n");
    printf("\n_________________________________________________________\n");
    getch();
    

   for(i3=0;i3 < dimensao;i3++){ // laço para obter a matriz 'a' de 'entrada.txt'
        for(j3=0;j3 < dimensao;j3++){
           fscanf(fp,"%lf",&a[i3][j3]);
           
        }
     }
     
     fclose(fp); //fechamento do arquivo fp
     
         
   fp2 = fopen("entrada2.txt","r"); //  abre o arquivo 'entrada.txt' no modo apenas para leitura

   if(fp2==NULL){  // verifica a existencia do arquivo 'entrada.txt' caso não exista, o programa é finalizado
      printf("Arquivo 'entrada.txt' nao encontrado.\n\n\n\n");
      system("pause");
      return 0;
   }
   
   for(i3=0;i3<dimensao;i3++){  // laço para obter o vetor 'b' de 'entrada.txt'
         fscanf(fp2,"%lf",&b[i3]);
   }
   
   for(i3=0;i3<dimensao;i3++){   // laço para obter o vetor x°, estimativa inicial. Do arquivo 'entrada.txt'
         fscanf(fp2,"%lf",&x[0][i3]);
   }
   

    i3=0;
    j3=0;
    
    //gravação no arquivo
    fp = fopen("saida.txt","w+");
    
    fprintf(fp,"\n%lf",dr);
               
    while(dr>=erro){  // realiza as operações para encontrar o vetor Xk enquanto não é atigida a precisão definida
              
      for(i3=0;i3<dimensao;i3++){       // laço para achar os 'i3' termos do vetor Xk, de uma k-ésima iteração        
        ps2 = Ps(a,x,k3,i3,dimensao);
        x[k3][i3]= ((b[i3] + ps2)/(a[i3][i3])); 
        
      }

        dr = Dr(x,k3,dimensao);
        k3++;
        fprintf(fp,"\n%.10lf",dr);
     }


     //Impressão da matriz resultante no arquivo
     for(i3=0;i3<dimensao;i3++){
         fprintf(fp,"\n");
         
         for(j3=0;j3<dimensao;j3++){
             fprintf(fp,"%lf\t",x[i3][j3]);
         }
     }

     fclose(fp2); //fechando o arquivo da gravação
     
     getch();
     contagem(); //procedimento contagem
     

}

//Procedimento contagem()
void contagem(){
         int j = 0;
           
         for(int i = 0; i < 20; i++){
                  system("color ae");
                 while(j < 100){
                         printf("%d\t",j++); system("color ea"); }
         }
             
             system("color 1f");
             system("cls");
        printf("\n  ...    ........   ......   .   ........   ......   .......     .......  \n");
		printf("\n.     .  .      .   .     .  .   .          .    .   .      .    .     .  \n");
		printf("\n.     .  .    .     .    .   .   .          .    .   .       .   .     .  \n");
		printf("\n  ...    . .        .  .     .   .  .....   ......   .        .  .......  \n");
		printf("\n         .    .     . .      .   .  .   .   .    .   .        .           \n");
		printf("\n         .      .   .   .    .   .      .   .    .   .       .            \n");
		printf("\n         .........  .     .  .   ........   .    .   ........             \n\n\n\n");   
        
        printf("\t\t\tpor ter utilizado nosso programa\n");
        getch();         
}

//Prototipo o procedimento cabecalho()
void cabecalho(){
     system("color f9");
     printf("\t\t_-_-\_-_-\_-_-\_-_-\_-_-\_-_-\_-_-\_-_-\_-_-\n");
     printf("\t\t\tUniversidade de Brasilia\n");
     printf("\t\t\tCleiton da Silva Gomes \n");
     printf("\t\t_-_-\_-_-\_-_-\_-_-\_-_-\_-_-\_-_-\_-_-\_-_-\n");

    
}
