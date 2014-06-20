//+------------------------------------------------------------------+
//|                           Resolução de EDO por método de Taylor  |
//|                         Copyright © 2012, Cleiton da Silva Gomes |
//|                                   http://www.softwarecsg.com.br  |
//+------------------------------------------------------------------+

#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#define f(x,y) ((1+2*x)*sqrt(y))
#define f1(x,y) (2*sqrt(y) + (1/(2*sqrt(y)) + (2*x)/(2*sqrt(y))) * ((1+2*x)*sqrt(y)))

void fim();
void Euller(double, int);

int main ()
{
	double a,b,h;
	int n,opcao;
	
	do
	{
		printf("            Resolucao de Equacoes Diferenciais Pelo Metodo de Euller\n");
		printf("\n\n\n\t(1)..........................Entrar com a, b e n\n");
		printf("\t(2)..........................Entrar com h e n\n");
		printf("\t(3)..........................Entrar Com Novos Valores de a e b\n");
		printf("\t(0)..........................Sair\n");
		printf("\nOpcao Desejada: ");
		scanf("%d",&opcao);
			
		switch (opcao)
		{
			case 1:
				
				printf("Entre com a: ");
				scanf("%lf",&a);
				printf("Entre com b: ");
				scanf("%lf",&b);
				printf("Entre com o numero de intervalos: ");
				scanf("%d",&n);
				h = (b-a)/n;
				Euller(h,n);
		
				break;
			
			case 2:
				printf("Entre com h: ");
				scanf("%lf",&h);
				printf("Entre com o numero de intervalos: ");
				scanf("%d",&n);
				Euller(h,n);
				break;
			
			case 3:
				main();
				break;
				
			case 0:
				exit(0);
				break;
		}
		
	} while(opcao);
	
	
	return 0;
}

void Euller(double h, int n)
{
	double *y,*x;
	int i;
	
	y = (double *)calloc(n+1, sizeof(double));
	x = (double *)calloc(n, sizeof(double));
	
	printf("\nValores Iniciais:\n");
	
	printf("Entre com x0: ");
	scanf("%lf",&x[0]);
	printf("Entre com y(x0): ");
	scanf("%lf",&y[0]);
	printf("\nIteracoes\n");
	for(i=1; i<n; i++)
	{
		x[i] += x[i-1]+h;
	}
	
	for(i=1; i<=n; i++)
	{
		y[i] = y[i-1] + h*f(x[i-1], y[i-1]) + f1(x[i-1],y[i-1])*pow(h,2)/2;
		printf("y%d = %lf\n",i,y[i]);
	}
	
}

