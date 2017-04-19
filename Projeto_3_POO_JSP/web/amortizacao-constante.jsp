<%@page import="java.text.NumberFormat"%>
<html>
    <head>
    </head>
    <body>
        <%
            double juros = 0;
            double valor = 0;
            int parcela = 0;
            try {
                juros = Double.parseDouble(request.getParameter("juros"));
                juros = juros / 100;
                parcela = Integer.parseInt(request.getParameter("tempo"));
                valor = Double.parseDouble(request.getParameter("emprestimo"));
            } catch (Exception e) {
            }
        %>
        <form>
            Emprestimo <input step="0.01" type="number" name="emprestimo" style="color:black"/><br /><br />
            Tempo <input step="0.01" type="number" name="tempo" style="color:black"/><br /><br />
            Taxa em % <input step="0.01" type="number" name="juros" style="color:black"/><br /><br />
            <input type="submit" value="Calcular" style="color:black">
        </form>

        <table border='1'>
            <tr>
                <th> Numero da Prestação </th>
                <th> Parcela </th>
                <th> Amortização </th>
                <th> Juros </th>
                <th> Saldo Devedor </th>                
            </tr>
            <%
                double Nprestacao = 0;
                double Juros = 0;
                double Amort = 0;
                double AmorTotal = 0;
                double JurosTotal = 0;
                double S = valor;
                NumberFormat formato = NumberFormat.getCurrencyInstance();
                Amort = valor / parcela;
                for (int i = 1; i <= parcela; i++) {                    
                    if(i == 1){
                        Nprestacao = Amort + (juros * valor);
                        Juros = (juros * valor);
                        JurosTotal = Juros + JurosTotal;
                        S = S - Amort;
                        AmorTotal = Amort + AmorTotal;
                    }else{
                        Nprestacao = Amort + (juros * (valor -((i-1)*Amort)));
                        Juros = (juros * (valor -((i-1)*Amort)));
                        JurosTotal = Juros + JurosTotal;
                        Amort = S - Amort;
                        AmorTotal = Amort + AmorTotal;
                    }
                    
            %>
            <tr>
                <td align="center"> <%if (i == 0) {%>
                    <%=i = 0%>
                    <%} else {%>
                    <%=  i%><%= "º"%>    </td>
                    <%}

                    %>
                <td align="center"> <%= formato.format(Nprestacao)%> </td>
                <td align="center">  <%= formato.format(Amort)%> </td>
                <td align="center"> <%= formato.format(Juros)%>   </td>
                <td align="center">  <%= formato.format(S)%>    </td> 
            </tr>                            
            <%}%>
            <tr>

                <th>Total:
                <td align="center"><%=formato.format(valor)%></td>
                <td align="center"><%=formato.format(AmorTotal)%></td>
                <td align="center"><%=formato.format(JurosTotal)%></td>
                <td align="center"><%=formato.format(Amort)%></td>

                </th>

            </tr>
        </table>
    </body>
</html>
