<%--
  ~ Copyright (c) 2020, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
  ~
  ~ WSO2 Inc. licenses this file to you under the Apache License,
  ~ Version 2.0 (the "License"); you may not use this file except
  ~ in compliance with the License.
  ~ You may obtain a copy of the License at
  ~
  ~ http://www.apache.org/licenses/LICENSE-2.0
  ~
  ~ Unless required by applicable law or agreed to in writing,
  ~ software distributed under the License is distributed on an
  ~ "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
  ~ KIND, either express or implied.  See the License for the
  ~ specific language governing permissions and limitations
  ~ under the License.
  --%>

<%@page import="io.asgardeo.java.oidc.sdk.SSOAgentConstants" %>
<%@page import="io.asgardeo.java.oidc.sdk.bean.SessionContext" %>
<%@ page import="io.asgardeo.java.oidc.sdk.bean.User" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>

<%
    final HttpSession currentSession = request.getSession(false);
    final SessionContext sessionContext = (SessionContext)
            currentSession.getAttribute(SSOAgentConstants.SESSION_CONTEXT);
    final String idToken = sessionContext.getIdToken();
    
    String name = null;
    Map<String, Object> customClaimValueMap = new HashMap<>();
    
    if (idToken != null) {
        final User user = sessionContext.getUser();
        customClaimValueMap = user.getAttributes();
        name = user.getSubject();
    }
%>

<html>
<head>
    <meta charset="UTF-8">
    <title>Home</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="theme.css">
</head>
<body>

    <div class="ui two column centered grid">
        <div class="column center aligned">
            <img src="images/logo-dark.svg" class="logo-image">
        </div>
        <div class="container">
            <div class="header-title">
                <h1>
                    Java-Based OIDC Authentication Sample <br> (OIDC - Authorization Code Grant)
                </h1>
            </div>
            <div class="content">
                <h2>
                    Hi <%=name%>
                </h2>
                <% if (!customClaimValueMap.isEmpty()) { %>
                <h3>
                    User Details
                </h3>
                <div>
                    <% for (String claim : customClaimValueMap.keySet()) { %>
                    <dl class="details">
                        <dt><b><%=claim%>: </b><%=customClaimValueMap.get(claim).toString()%></dt>
                    </dl> 
                    <% } %>
                <% } else { %>
                    <h3>
                        No user details Available. Configure SP Claim Configurations.
                    </h3>
                <% } %>

                </div>
                <form action="logout" method="GET">
                    <div class="element-padding">
                        <button class="btn primary" type="submit">Logout</button>
                    </div>
                </form>
            </div>
        </div>
        <img src="images/footer.png" class="footer-image">
    </div>

</body>
</html>
