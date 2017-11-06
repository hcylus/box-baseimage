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
    margin-top:10px;
    margin-bottom:10px;
    color: #000000;
    font: normal bold 130%
    Georgia,Serif;
    background-color:#f0f0f0;
    }
    tr.gray {
    background-color:#f0f0f0;
    }
    h2 {
    padding:5px;
    margin-top:5px;
    margin-bottom:5px;
    font: italic bold 110% Georgia,Serif;
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
    border: dotted
    1px #666;
    margin: 2px;
    content:
    2px;
    padding: 2px;
    }
    table.border, th.border, td.border {
    border:
    1px solid black;
    border-collapse:collapse;
    }
#robot-summary-table {
    text-align: center;
    border-collapse: collapse;
}
#robot-summary-table th {
    font-weight: normal;
    padding: 3px;
}
#robot-summary-table td {
    font-weight: bold;
    border-left: 1px solid #888;
    margin: 0px;
    padding: 3px;
}
#robot-summary-table .table-upper-row {
    border-bottom: 1px solid #888;
}
#robot-summary-table .fail {
    color: #f00;
}
#robot-summary-table .pass {
    color: #0f0;
}

  </style>
</head>
<body>

  <div class="header">
    <% def spc = "&amp;&nbsp;&amp;&nbsp;" %>
    <!-- GENERAL INFO -->
    <table>
      <tr class="gray">
        <td align="right">
        <%
        
        if (build.result.toString() == 'SUCCESS') {
        %>
              <img src="${rooturl}static/e59dfe28/images/32x32/blue.gif" />
          <% 
          } else if (build.result.toString() == 'FAILURE') {
          %>
              <img src="${rooturl}static/e59dfe28/images/32x32/red.gif" />
          <%} else {%>
              <img
                src="${rooturl}static/e59dfe28/images/32x32/yellow.gif" />
            <%}%>
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
  
  
  <!-- robotframework testcase result. -->

  <%
  
     def hudson.EnvVars env
     env = build.getEnvironment()
     
  def robotAction = build.getAction(hudson.plugins.robot.RobotBuildAction)

  if (robotAction != null) {
  %>

  <div class="content">
    <h1>SATP Report</h1>

     <%
     def robotResult = robotAction.result

     if (robotResult != null) {
     %>


     <table id="robot-summary-table">
     <thead>
         <tr>
             <th></th>
             <th>Total</th>
             <th>Failed</th>
             <th>Passed</th>
             <th>Pass %</th>
         </tr>
     </thead>
     <tbody>
       <tr>
          <th>Critical tests</th>
          <td class="table-upper-row" style="border-left: 0;">${robotResult.criticalTotal}</td>
          <td class="table-upper-row">
          <%
          def criticalFails = 'pass'
          if (robotResult.criticalFailed > 0) {
             criticalFails = 'fail'
          }
          %>
          <span class="${criticalFails}">${robotResult.criticalFailed}</span>
          </td>
          <td class="table-upper-row">${robotResult.criticalPassed}</td>
          <td class="table-upper-row">${robotAction.criticalPassPercentage}</td>
       </tr>
       <tr>
         <th>All tests</th>
         <td style="border-left: 0;">${robotResult.overallTotal}</td>
         <td>
         <%
         def totalFails = 'pass'

         if (robotResult.overallFailed > 0) {
             totalFails = 'fail'
         }
         %>
         <span class="${totalFails}">${robotResult.overallFailed}</span>
         </td>
         <td>${robotResult.overallPassed}</td>
         <td>${robotAction.overallPassPercentage}</td>
       </tr>



     </tbody>
     </table>
         <a href="${rooturl}/${robotAction.owner.url}/${robotAction.urlName}">&gt;Browse results</a><br />
         <%
         if (robotAction.hasProperty('logFileLink') != null) {
         %>
         <a href="${rooturl}/${robotAction.owner.url}/${robotAction.urlName}/report/${robotAction.logFileLink}">&gt;Open ${robotAction.logFileLink}</a><br />
         <%
         }
         if (robotAction.hasProperty('logHtmlLink') != null) {
         %>
  	      <a href="${rooturl}/${robotAction.owner.url}/${robotAction.urlName}/report/${robotAction.logHtmlLink}">&gt;Open ${robotAction.logHtmlLink}</a><br />
       <% } %>

     <% } %>
  </div>

  <% } %>

  <!-- CHANGE SET -->
  <div class="content">

    <% def changeSet = build.changeSet
    if(changeSet != null) {
        def hadChanges = false
        def count = 0 %>
      <a href="${rooturl}${build.url}/changes">
        <h1>Changes</h1>
      </a>

      <%

      changeSet.logs.each() { cs ->
          hadChanges = true

      
      %>
        <j:set var="hadChanges" value="true" />
        <h2>${cs.msgAnnotated}</h2>
        <p>
          by
          <em>${cs.author}</em>
        </p>
        <table>
        <%
        
               cs.affectedFiles.each() { p->
        %>

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

  <div class="content">
    <!-- CONSOLE OUTPUT -->
    <a href="${rooturl}${build.url}/console">
      <h1>Console Output</h1>
    </a>
    <table class="console">
    <% build.getLog(50).each() { line-> %>
        <tr>
          <td>
            <tt>${line}</tt>
          </td>
        </tr>
        <% } %>
    </table>
    <br />
  </div>
</body>
</html>
