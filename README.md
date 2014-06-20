Métodos Numéricos e Álgebra Computacional para predição de cotações no mercado FOREX utilizando o framework 0MQ.
Curso de Engenharia de Software - UnB Gama
-------------------------------------------------------------------------------------------
Instalar ZEROMQ no Ubuntu:

Antes de começar:
Baixe a versão 3.2.1 do 0MQ disponível no seguinte endereço: http://download.zeromq.org/ e 
instale o libtool através do seguinte comando:
sudo apt-get install libtool autoconf automake uuid-dev build-essential

PASSO 1 (Configurar e instalar)
$ cd zeromq-3.2.1
$ ./configure
$ make
$ sudo make install
$ sudo ldconfig

PASSO 2 (Clonar o repositório)
Clone o repositório do 0MQ para executar algum exemplo:
git clone --depth=1 git://github.com/imatix/zguide.git

PASSO 3 (Compilar e Executar programa em linguagem C)
Entre na pasta examples (linguagem C) do projeto clonado e compile algum programa.c através do seguinte comando:
gcc -o nomePrograma nomePrograma.c -lzmq
Para executar:
./nomePrograma

-------------------------------------------------------------------------------------------


