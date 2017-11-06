<html>
<head>
    <title>${project.name}</title>
    <style>
        body table, td, th, p, h1, h2 {
            margin:0;
            font:normal normal
            100% Georgia, Serif;
            background-color: #ffffff;
        }
        h1, h2 {
            border-bottom:dotted 1px #999999;
            padding:5px;
            margin-top:0px;
            margin-bottom:0px;
            color: #000000;
            font: normal bold 130%
            Georgia,Serif;
            background-color:#4A95CE;
        }
        tr.gray {
            background-color:#4A95CE;
        }
        h2 {
            padding:5px;
            margin-top:5px;
            margin-bottom:5px;
            font: normal 110% Georgia,Serif;
        }
        .bg2 {
            color:black;
            background-color:#E0E0E0;
            font-size:110%
        }
        th {
            font-weight: bold;
        }
        tr, td, th {
            padding:2px;
        }
        td.test_passed {
            color:blue;
        }
        td.test_failed {
            color:red;
        }
        td.center {
            text-align: center;
        }
        td.test_skipped {
            color:grey;
        }
        .console {
            font: normal normal 90% Courier New,
            monotype;
            padding:0px;
            margin:0px;
        }
        div.content, div.header {
            background: #ffffff;
            border: solid
            1px #666;
            margin: 2px;
            content:
            2px;
            padding: 2px;
        }
        table.border, th.border, td.border {
            border: 1px solid black;
            border-collapse:collapse;
        }

        /* ========================= sortable table ========================= */
        table.sortable a.sortheader {
          text-decoration: none;
          color: black;
          display: block;
        }
        table.sortable span.sortarrow {
          color: black;
          text-decoration: none;
        }

        /* bigtable */

        .bigtable tr {
          border: 1px solid #bbb;
          padding: 3px 4px 3px 4px;
        }
        table.bigtable.pane > tbody > tr > td:last-child {
          border-right: none;
        }

        .pane-frame table, .pane-frame .bigtable tr {
          border: none; /* Border will be provided by the pane-frame */
        }

        .bigtable th {
          font-weight: bold;
          border: none;
          background-color: #f0f0f0;
          padding: 6px 4px;
          white-space: nowrap;
        }

        .bigtable td {
          vertical-align: middle;
          padding: 3px 4px 3px 4px;
        }
        /* pane */

        .pane-frame {
          border: solid 1px #f0f0f0;
          border-radius: 4px;
        }

        #side-panel .pane-frame:hover, #side-panel .pane-frame.mouseover {
          border: solid 1px #cecece;
        }

        .pane-header, .pane-footer {
          padding: 8px 0px;
          background-color: #eee;
          border: solid 1px #f3f3f3;
          border-left: none;
          border-right: none;
          color: #3b3b3b;
        }
        .pane-header {
          border-top: none;
          border-top-left-radius: 4px;
          border-top-right-radius: 4px;
        }
        .pane-footer {
          border-bottom: none;
          border-bottom-left-radius: 4px;
          border-bottom-right-radius: 4px;
        }

        .pane td {
          padding: 4px 4px 3px 4px;
          vertical-align: middle;
        }

        table.pane {
          width: 100%;
          border-collapse: collapse;
          border: 1px #bbb solid;
        }

        td.pane {
          padding: 3px 4px 3px 4px;
          vertical-align: middle;
        }

        table.stripped tr:nth-child(even) {
          background: #fbfbfb;
        }
        table.stripped-even tr:nth-child(even) {
          background: #fbfbfb;
        }
        table.stripped-odd tr:nth-child(odd) {
          background: #fbfbfb;
        }

        div.pane-header {
          font-weight: bold;
          padding-right: 24px;
        }

        div.pane-header .collapse {
            float: right;
          margin-left: 3px;
        }

        th.pane {
          font-weight: bold;
        }
    </style>
</head>
<body>


<div class="header">
    <% def spc = "&nbsp;&nbsp;" %>
    <!-- GENERAL INFO -->
    <table>
        <tr class="gray" >
            <td align="right">
                <% if (build.result.toString() == 'SUCCESS') { %>
                <img src="${rooturl}static/e59dfe28/images/32x32/blue.gif" />
                <% } else if (build.result.toString() == 'FAILURE') { %>
                <img src="${rooturl}static/e59dfe28/images/32x32/red.gif" />
                <% } else { %>
                <img src="${rooturl}static/e59dfe28/images/32x32/yellow.gif" />
                <% } %>
            </td>
            <td valign="center">
                <b style="font-size: 200%;">BUILD ${build.result.toString()}</b>
            </td>
        </tr>
        <tr>
            <td>Build URL</td>
            <td>
                <a href="${rooturl}${build.url}">${rooturl}${build.url}</a>
            </td>
        </tr>
        <tr>
            <td>Project:</td>
            <td>${project.name}</td>
        </tr>
        <tr>
            <td>Date of build:</td>
            <td>${it.timestampString}</td>
        </tr>
        <tr>
            <td>Build duration:</td>
            <td>${build.durationString}</td>
        </tr>
        <tr>
            <td>Build cause:</td>
            <td>
                <% for (hudson.model.Cause cause : build.causes) { %>
                ${cause.shortDescription}
                <% } %>
            </td>
        </tr>
        <tr>
            <td>Changes</td>
            <td><a href="${rooturl}${build.url}changes">${rooturl}${build.url}changes</a></td>
        </tr>
        <tr>
            <td>Build description:</td>
            <td>${build.description}</td>
        </tr>
        <tr>
            <td>Built on:</td>
            <td>
                <% if (build.builtOnStr != '') { %>
                ${build.builtOnStr}
                <% } else {%>
                master
                <% } %>
            </td>
        </tr>
    </table>
</div>



<!-- abs report result... -->
<%
def hudson.EnvVars env
env = build.getEnvironment()
def absReportBuildAction = build.getAction(com.sicent.satp.jenkinsci.plugins.absplugin.AbsReportBuildAction)
if (absReportBuildAction != null) {
%>

<div class="content">
    <%
    def result = absReportBuildAction.result
    if (result != null) {

    def steps = result.getSteps()
    %>
	
    <div>
        <% steps.each{step-> %>
        ${step.transform()}
        <% } %>
    </div>
    <% } %>
</div>

<% } %>


<!-- ARTIFACTS -->
<%

def artifacts = build.artifacts

if (artifacts != null && artifacts.size() > 0) {
%>
<div class="content">
    <h1>Build Artifacts</h1>
    <ul>
        <% artifacts.each() { f-> %>
        <li>
            <a href="${rooturl}${build.url}artifact/${f}">${f}</a>
        </li>
        <% } %>
    </ul>
</div>
<% } %>

<!-- CHANGE SET -->
<div class="content">

    <%
    def changeSet = build.changeSet
    if(changeSet != null) {
    def hadChanges = false
    def count = 0
    %>
    <a href="${rooturl}${build.url}/changes">
        <h1>Changes</h1>
    </a>

    <% changeSet.logs.each() { cs ->
    hadChanges = true
    %>
    <j:set var="hadChanges" value="true" />
    <p style="background-color: #EEF2F5;">${cs.msgAnnotated}</p>
    <p>
        by
        <em>${cs.author}</em>
    </p>
    <table>
        <% cs.affectedFiles.each() { p-> %>
        <tr>
            <td width="10%">${spc}${p.editType.name}</td>
            <td>
                <tt>${p.path}</tt>
            </td>
        </tr>
        <% } %>

    </table>

    <% } %>
    <%
    if (!hadChanges) {
    %>
    <p>No Changes</p>
    <% } %>

    <% } %>
    <br />
</div>

</body>
</html>
