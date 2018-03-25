#include<stdio.h>
#include<math.h>
#include<string.h>
#include<stdlib.h>

double f(double x)
{
    double s;
    return s = 10 * exp(-(pow((x-50),2))*(1./(2*10*10)));
}


void main()
{

    FILE *arq;
    arq = fopen("deriva_lax.txt", "w+");


    double S,s,estado_novo[101],estado_antigo[101],k;
    int tmax,i,j,jmax,t;

   tmax = 10000;
    k = 0.49;
    jmax = 101;


//condição inicial
for (j = 0 ; j < jmax ; j++)
    {
        estado_antigo[j] = f(j);

    }


    for(t = 0 ; t < tmax ; t+=1)
    {



	
		for(j = 0 ; j < jmax ; j++)
		{

		    fprintf(arq, "%d %lf\n", j,estado_antigo[j]);
		}

		fprintf(arq, "\n\n");
	






	estado_novo[0] = (1./2.)*( estado_antigo[jmax-1] + estado_antigo[1] ) - k * ( estado_antigo[1] - estado_antigo[jmax-1] );


        for(j = 1 ; j < jmax-1 ; j++)
        {


            estado_novo[j] = (1./2.)*( estado_antigo[j-1] + estado_antigo[j+1] ) - k * ( estado_antigo[j+1] - estado_antigo[j-1] );

        }



estado_novo[jmax-1] = (1./2.)*( estado_antigo[jmax-2] + estado_antigo[0] ) - k * ( estado_antigo[0] - estado_antigo[jmax-2] );



        for(j = 0 ; j < jmax ; j++)
        {
            estado_antigo[j] = estado_novo[j];

        }





    }







    fclose(arq);

}

