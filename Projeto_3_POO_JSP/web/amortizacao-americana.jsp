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
            Empréstimo: <input step="0.01" type="number" name="emprestimo" style="color:black"/><br /><br />
            Quantidade de Prestações: <input step="0.01" type="number" name="tempo" style="color:black"/><br /><br />
            Taxa em %: <input step="0.01" type="number" name="juros" style="color:black"/><br /><br />
            <input type="submit" value="Calcular" style="color:black">
        </form>

        <table border='1'>
            <tr>
                <th> Numero da Prestação </th>
                <th> Saldo Devedor </th>
                <th> Amortização </th>
                <th> Juros </th>
                <th> Prestação (Amortização + juros) </th>
            </tr>
            <%
                double Nprestacao = 0;
                double Juros = 0;
                double Amort = 0;
                double AmorTotal = 0;
                double JurosTotal = 0;
                NumberFormat formato = NumberFormat.getCurrencyInstance();
                for (int i = 1; i <= parcela; i++) {
                    Juros = valor * juros;
                    JurosTotal = JurosTotal + Juros;
                    if (i != parcela) {
                        AmorTotal = AmorTotal + Juros;
                    }
                    Nprestacao = Juros;
                    if (valor < 0) {
                        valor = 0;
                    }
                    if (i == parcela) {
                        Amort = valor;
                        Nprestacao = Nprestacao + Amort;
                    }

                    if (i == parcela) {
                        valor = 0;
                    }

            %>
            <tr>
                <td align="center"> <%if (i == 0) {%>
                    <%=i = 0%>
                    <%} else {%>
                    <%=  i%><%= "º"%>    </td>
                    <%}

                    %>
                <td align="center"> <%= formato.format(valor)%> </td>
                <td align="center">  <%= formato.format(Amort)%> </td>
                <td align="center"> <%= formato.format(Juros)%>   </td>
                <td align="center">  <%= formato.format(Nprestacao)%>    </td> 
            </tr>                            
            <%}%>
            <tr>

                <th>Total:
                <td align="center"><%=formato.format(valor)%></td>
                <td align="center"><%=formato.format(Amort)%></td>
                <td align="center"><%=formato.format(JurosTotal)%></td>
                <td align="center"><%=formato.format(Nprestacao + AmorTotal)%></td>

                </th>

            </tr>
        </table>
    </body>
</html>
