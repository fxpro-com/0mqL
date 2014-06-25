#include <zmq_bind.mqh>


int client,server,context;
//TODO: the below is needed or else you might get some nice memory leaks!
/*
int init(){

   Print("using zeromq version "+z_version_string());
   context = z_init(1);
   client = z_socket(context,ZMQ_PUB);
   
   if(z_bind(client,"tcp://127.0.0.1:2001") == -1)
       return(-1);
   
   z_send("alpha", "Currency Pair Stream Connected");

}
*/

int deinit()
{
  z_close(client);
  z_close(server);
  z_term(context);
  return(0);
}
//+------------------------------------------------------------------+
//| expert start function                                            |
//+------------------------------------------------------------------+

int start()
{
  Print("using zeromq version "+z_version_string());
  
  context = z_init(1);
  client = z_socket(context,ZMQ_REQ); //server: receives first
  server = z_socket(context,ZMQ_REP); //client: sends first 

   //tcp://127.0.0.1:2027
  if(z_bind(server,"tcp://*:5555")==-1){
   Sleep(100);
   Print("Erro no endereco\n");
   return(-1);
  }
    
  if (z_connect(client,"tcp://192.168.1.185:5555")==-1){
    Sleep(100);
    Print("Erro no endereco 2\n");
    return(-1);
  }
    
  z_send(client,"I am a message");
  Print("message received is " +z_recv(server));
  
     
   //_-_-_ Apresentação na Tela
   Comment(
       "Mensagem recebida  = ",z_recv(server)  ,"\n",
       "Impressao de   = ",0  ,"\n",
      
      ""
   );
    

  return(0);
}
//+------------------------------------------------------------------+

