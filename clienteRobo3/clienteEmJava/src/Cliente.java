import java.io.File;
import java.io.FileOutputStream;

import org.zeromq.ZMQ;

public class Cliente {

	public final static String diretorio = "/home/hebert/.wine/drive_c/Program Files (x86)/MetaTrader - Alpari UK/MQL4/Files/correlacao.txt"; 
	public final static String metodoNumerico = "correlacao";
	
	public static void main(String[] args) {
        ZMQ.Context contexto = ZMQ.context(1);

        System.out.println("Estabelecendo conexão com o servidor...");

        ZMQ.Socket requisicao = contexto.socket(ZMQ.REQ);
        requisicao.connect("tcp://192.168.1.4:5555");
        System.out.println("Conexão estabelecida!");
        int n = 1;
        while(n!=0){
            String mensagem = metodoNumerico;
            requisicao.send(mensagem.getBytes(), 0);
            byte[] reply = requisicao.recv(0);
            gravaArquivo(new String(reply));
            System.out.println("Correlacao recebida: " + new String(reply) );
            n++;
        }
        requisicao.close();
        contexto.term();
    }
  
    /*
     * Metodo responsavel por adicionar a correlação recebida do servidor
     * em um arquivo para que possa ser lido pelo MetaTrader
     */
	
    public static void gravaArquivo(String texto){
    	try {    
            File arquivo;
            arquivo = new File(diretorio);  
            FileOutputStream gravacao = new FileOutputStream(arquivo);    
            gravacao.write(texto.getBytes());  
            gravacao.close();  
        }  
        catch (Exception e) {  
            e.printStackTrace();  
        }  
    }
    
}