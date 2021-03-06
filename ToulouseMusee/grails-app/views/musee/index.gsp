<%@ page import="toulousemusee.Adresse; toulousemusee.Musee" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'musee.label', default: 'Musee')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>
<a href="#list-musee" class="skip" tabindex="-1"><g:message code="default.link.skip.label"
                                                            default="Skip to content&hellip;"/></a>

<div class="nav" role="navigation">
    <ul>
        <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
        <li><g:link class="create" action="create"><g:message code="default.new.label"
                                                              args="[entityName]"/></g:link></li>
    </ul>
</div>

<div id="list-musee" class="content scaffold-list" role="main">
    <h1><g:message code="default.list.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <g:form>
        <fieldset class="form">
            <div class="fieldcontain">
                <label>
                    Nom musée contient :
                </label>
                <g:textField name="nom"/>
                <label for="codepostal">
                    Code postal:
                </label>
                <g:select from="${Adresse.list()}" optionValue="codePostal" optionKey="codePostal"
                          noSelection="['': '']" name="codepostal"/>
            </div>

            <div class="fieldcontain">
                <label for="nomrue">
                    Nom rue contient:
                </label>
                <g:textField name="nomrue"/>
            </div>

            <div style="float: right">
                <g:actionSubmit action="doSearchMusees" value="Rechercher"/>
            </div>
        </fieldset>

    </g:form>

    <table>
        <thead>
        <tr>

            <g:sortableColumn property="nom" title="${message(code: 'musee.nom.label', default: 'Nom')}"/>

            <g:sortableColumn property="telephone"
                              title="${message(code: 'musee.telephone.label', default: 'Telephone')}"/>

            <g:sortableColumn property="accesMetro"
                              title="${message(code: 'musee.accesMetro.label', default: 'Acces Metro')}"/>

            <g:sortableColumn property="accesBus"
                              title="${message(code: 'musee.accesBus.label', default: 'Acces Bus')}"/>

            <th><g:message code="musee.adresseMusee.label" default="Adresse Musee"/></th>

            <g:sortableColumn property="horairesOuverture"
                              title="${message(code: 'musee.horairesOuverture.label', default: 'Horaires Ouverture')}"/>

            <th><g:message code="musee.gestionnaire.label" default="Gestionnaire"/></th>


            <g:sortableColumn property="isPrefere"
                              title="${message(code: 'musee.isPrefere.label', default: 'Favoris')}"/>

        </tr>
        </thead>
        <tbody>
        <g:each in="${museeInstanceList}" status="i" var="museeInstance">
            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                <td><g:link action="show"
                            id="${museeInstance.id}">${fieldValue(bean: museeInstance, field: "nom")}</g:link></td>

                <td>${fieldValue(bean: museeInstance, field: "telephone")}</td>

                <td>${fieldValue(bean: museeInstance, field: "accesMetro")}</td>

                <td>${fieldValue(bean: museeInstance, field: "accesBus")}</td>

                <td>${fieldValue(bean: museeInstance, field: "adresseMusee")}</td>

                <td>${fieldValue(bean: museeInstance, field: "horairesOuverture")}</td>

                <td>${fieldValue(bean: museeInstance, field: "gestionnaire")}</td>


                <td>
                    <g:form id="${museeInstance.id}">

                        <g:actionSubmit action="doAddFavoris" value="Ajouter &#10 à la liste des musées"
                                        title="Ajouter à la liste des musées" disabled="${museeInstance.isPrefere}"></g:actionSubmit>
                    </g:form>
                </td>

            </tr>
        </g:each>
        </tbody>
    </table>
</div>

<div class="pagination">
    <g:paginate max="5" total="${museeInstanceCount ?: 0}" name=""/>
</div>
<g:if test="${toulousemusee.Musee.list().isPrefere.contains(true) == true}">
<div id="encart" style="float: right; right: 2%; top: 30%; font-size: 80%;">

    <table>
        <h1>Mes musées préférés</h1>
        <thead>
        <tr>
            %{--<g:sortableColumn property="nom" title="${message(code: 'musee.nom.label', default: 'Nom')}"/>--}%
            %{--<g:sortableColumn property="favoris" title="${message(code: 'musee.nom.label', default: 'Favoris')}"/>--}%
            <th>Nom</th>
            <th>Actions</th>
        </tr>
        </thead><tbody>
    <g:each in="${Musee.findAll()}" status="i" var="museeInstance">
        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
            <g:if test="${museeInstance.isPrefere == true}">
                <td>${fieldValue(bean: museeInstance, field: "nom")}</td>

                <td><g:form id="${museeInstance.id}">
                    <g:actionSubmit action="doRemoveFavoris" value="Supprimer &#10 de ma liste de musée"/>
                    <g:actionSubmit action="doDemandeVisite" value="Effectuer &#10 une demande de visite"/>
                </g:form></td>
            </g:if>

        </tr>
    </g:each>
    </tbody>
    </table>
</div>
</g:if>
</body>
</html>
