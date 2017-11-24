<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/xml" prefix="x" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>

<c:set var="contexto" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>SQL</title>
        <link rel="stylesheet" type="text/css" href="${contexto}/CSS/estilo.css" />
    </head>
    <body>
        <br/>
        <table id="cabecera">
            <tr>
                <th>Librer&iacute;a</th>
                <th>Prefijo</th>
                <th>URI</th>

            </tr>
            <tr>
                <td>SQL</td>
                <td class="etiqueta" style="text-align: center;">sql</td>
                <td class='codigo' style="text-align: center;"><c:url value="http://java.sun.com/jsp/jstl/sql" /></td>

            </tr>

        </table>
        <br/>
        <table>
            <tr>
                <th>Significado</th>
                <th>Etiqueta</th>
                <th>Atributos</th>
                <th>Requerido</th>
                <th>Ejemplo</th>
                <th>Salida</th>
            </tr>
            
            <tr>
                <td>Crea la fuente de datos y la vincula con una variable</td>
                <td class="etiqueta">setDataSource</td>
                <td><em>driver</em><br/>
                    <em>url</em><br/>
                    <em>user</em><br/>
                    <em>password</em><br/>
                    <em>dataSource</em><br/>
                    <em>var</em><br/>
                    <em>scope</em></td>
                <td>
                    No<br/>
                    No<br/>
                    No<br/>
                    No<br/>
                    No<br/>
                    No<br/>
                    No
                </td>
                <td><pre>&lt;%-- PARA CONEXIONES DIRECTAS --%>
&lt;sql:setDataSource var="conexion" driver="com.mysql.jdbc.Driver" 
    url="jdbc:mysql://localhost/pruebasJAVA" user="java2018" password="2018" />
&lt;%-- PARA POOL DE CONEXIONES" --%>
&lt;c:if test="\${ds == null}">
    &lt;sql:setDataSource var="ds" dataSource="jdbc/JSTL" scope="session"/>
&lt;/c:if></pre></td>
    
                <td>
<sql:setDataSource var="conexion" driver="com.mysql.jdbc.Driver" 
    url="jdbc:mysql://localhost/pruebasJAVA" user="java2018" password="2018" />

<c:if test="${ds == null}">
    <sql:setDataSource var="ds" dataSource="jdbc/JSTL" scope="session"/>
</c:if>
                </td>
            </tr>
            <tr>
                <td>Ejecuta una sentencia SELECT y guarda el resultado en una variable</td>
                <td class="etiqueta">query</td>
                <td><em>sql</em><br/>
                    <em>dataSource</em><br/>
                    <em>maxRows</em><br/>
                    <em>startRow</em><br/>
                    <em>var</em><br/>
                    <em>scope</em></td>
                <td>
                    No<br/>
                    No<br/>
                    No<br/>
                    No<br/>
                    No<br/>
                    No
                </td>
                <td><pre>&lt;sql:query dataSource="\${ds}" var="registros">
    SELECT * FROM clientes;
&lt;/sql:query>
&lt;c:forEach var="registro" items="\${registros.rows}">
    &lt;c:out value="\${registro.nombre}" />
&lt;/c:forEach></pre></td>
    
                <td><sql:query dataSource="${ds}" var="registros">
                        SELECT * FROM clientes;
                    </sql:query>
                    <c:forEach var="registro" items="${registros.rows}">
                        <c:out value="${registro.nombre}" /><br/>
                    </c:forEach>
                </td>
            </tr>
            <tr>
                <td>Ejecuta una sentencia SQL que no devuelve datos</td>
                <td class="etiqueta">update</td>
                <td><em>sql</em><br/>
                    <em>dataSource</em><br/>
                    <em>var</em><br/>
                    <em>scope</em></td>
                <td>
                    No<br/>
                    No<br/>
                    No<br/>
                    No
                </td>
                <td><pre>&lt;sql:update dataSource="\${ds}" 
    sql="insert into clientes values(0,?,?,?,?)">
    &lt;sql:param value="\${param.nombre}"/>
    &lt;sql:param value="\${param.apellidos}"/>
    &lt;sql:param value="\${param.direccion}"/>
    &lt;sql:param value="\${param.telefono}"/>
&lt;/sql:update></pre></td>
    
                <td>
                </td>
            </tr>
            <tr>
                <td>Convierte un par&aacute;metro a date de mysql</td>
                <td class="etiqueta">dateParam</td>
                <td><em>value</em><br/>
                    <em>type</em></td>
                <td>
                    No<br/>
                    No
                </td>
                <td><pre>&lt;c:catch var="ex">
    &lt;sql:update dataSource="\${ds}" 
        sql="insert into fechas values(0,?)">
        &lt;sql:dateParam value="\${fecha}" type="date"/>
    &lt;/sql:update>
    &lt;c:out value="Operaci&oacute;n realizada con &eacute;xito" />
&lt;/c:catch>
&lt;c:if test="\${ex != null}">
    &lt;c:out value="Ha ocurrido un error" />
&lt;/c:if></pre></td>
    
                <td><c:catch var="ex">
    <sql:update dataSource="${ds}" 
        sql="insert into fechas values(0,?)">
        <sql:dateParam value="${fecha}" type="date"/>
    </sql:update>
    <c:out value="Operación realizada con éxito" />
</c:catch>
<c:if test="${ex != null}">
    <c:out value="Ha ocurrido un error" />
</c:if>
                </td>
            </tr>
            <tr>
                <td>Asegurar que las operaciones sobre la base de datos se realizan con &eacute;xito o se deshacen los cambios</td>
                <td class="etiqueta">transaction</td>
                <td><em>dataSource</em><br/>
                    <em>isolation</em></td>
                <td>
                    No<br/>
                    No
                </td>
                <td><pre>&lt;sql:transaction dataSource="\${ds}" isolation="serializable">
    &lt;sql:update sql="insert into prueba values(0,?)">
        &lt;sql:param value="pepe" />
    &lt;/sql:update>
    &lt;c:catch var="ex">
        &lt;sql:update sql="insert into prueba values(0,?)">
            &lt;sql:param value="juan" />
        &lt;/sql:update>
        &lt;c:out value="bien" />
    &lt;/c:catch>
    &lt;c:if test="\${ex != null}">
        &lt;c:out value="mal" />
    &lt;/c:if>
&lt;/sql:transaction></pre></td>
    
<td><sql:transaction dataSource="${ds}" isolation="serializable">
        <sql:update sql="insert into prueba values(0,?)">
                            <sql:param value="juan" />
                        </sql:update>
        <c:catch var="ex">
        <sql:update sql="insert into prueba values(0,?)">
            <sql:param value="pepe" />
        </sql:update>
            <c:out value="bien" />
        </c:catch>
        <c:if test="${ex != null}">
            <c:out value="mal" />
        </c:if>
    </sql:transaction>
                </td>
            </tr>
        </table>
        <br/>
        
        <p id="volver"><a href='<c:url value="${contexto}/JSP/Sql/menuSQL.jsp"/>'>Men&uacute; SQL</a></p>

    </body>
</html>
