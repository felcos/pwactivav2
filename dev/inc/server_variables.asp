<div class="panel panel-primary">
    <div class="panel-heading">server variables</div>
    <div class="panel-body">
        <li>SERVER_NAME: <%= request.servervariables("SERVER_NAME") %></li>
        <li>REMOTE_ADDR: <%= request.servervariables("REMOTE_ADDR") %></li>
        <li>REMOTE_HOST: <%= request.servervariables("REMOTE_HOST") %></li>
    </div>
</div>