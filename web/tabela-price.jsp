<%--
    Document   : index
    Created on : 22 de mar. de 2021, 16:37:07
    Author     : cutekah
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    
    String errorMessage = null;
    int vp = 0;
    double taxa = 0;
    double meses = 0;
    
    double valorn = 0;
    double valormenos = 0;
    double pmt = 0;
    
    try {
        vp = Integer.parseInt(request.getParameter("vp"));
        taxa = Integer.parseInt(request.getParameter("taxa"));
        meses = Integer.parseInt(request.getParameter("meses"));
    } catch (Exception ex) {
        errorMessage = "Erro em validar os valores!";
    }
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%@include file="WEB-INF/jspf/header.jspf" %>
         <%@include file="WEB-INF/jspf/menu.jspf" %>
        
        <h1>Calculo TABELA-PRICE</h1>
        <p>Nome:Karina Namie Yamamoto Cardoso</p>
        <p>RA:1290481922021</p>
        
        <form>
            <label>Informe: Valor Presente:</label>
            <input type="number" name="vp">
            
            <label>Informe: Taxa de Juros(em %):</label>
            <input type="number" name="taxa">
           
            <label>Informe: Número de Períodos(em meses):</label>
            <input type="number" name="meses">
            
            <input type="submit" value="GERAR">
            
        </form>
        
        <% 
            valormenos = (1 + (taxa/100));
            valorn = (Math.pow(valormenos, meses));
            
            valormenos = (valorn - 1) / (valorn * (taxa/100));
            
            pmt = (vp / valormenos);
        %>
        
        <table border="1">
            <tr><th>N</th><th>Prestação</th><th>Amortização</th><th>Juros</th><th>Saldo Devedor</th></tr>
            <tr><th>-</th><th>R$</th><th>R$</th><th>R$</th><th>R$</th></tr>
            <tr><th>0</th><th>-</th><th>-</th><th>-</th><th> <%= vp %> </th></tr>
            <%                 
                double juros = 0;
                double amor = 0;
                double devedor = vp;
                
                for (int i = 1; i <= meses; i++) {
                    juros = devedor * (taxa/100);
                    amor = pmt - juros;
                    devedor = devedor - amor;
                    
                    if (i == meses) {
                        out.println("<tr><th>"+ i + "</th><th>" + pmt + "</th><th>" + amor + "</th><th>" + juros + "</th><th> 0.01 </th><tr>");
                        break;
                    }
                    out.println("<tr><th>" + i + "</th><th>" + pmt + "</th><th>" + amor + "</th><th>" + juros + "</th><th>" + devedor + "</th><tr>");
                }
                
                    
            %>
        </table>
        
        <br>
        
        <%@include file="WEB-INF/jspf/footer.jspf"%>
    </body>
</html>