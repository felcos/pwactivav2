<!DOCTYPE html>
<html>
<head>
  <meta charset=utf-8 />
  <style>
      @font-face {
      font-family: "HelveticaNeue";
      src: url("HelveticaNeueLTStdRoman.otf");
      }


      .cuadrado
      {
        font-family: "HelveticaNeue";
        font-size: 150%;
         width: 210px;
         height: 33px;
          bottom:0px;
         position:absolute; 
         background:antiquewhite;
         
         border: 1px hidden #FFFFFF;
          border-radius: 7px 7px 7px 0px;

          box-shadow: 0 1px 3px rgba(0,0,0,0.12), 0 1px 2px rgba(0,0,0,0.24);
  transition: all 0.3s cubic-bezier(.25,.8,.25,1);

          font-family: HelveticaNeue;
          font-size: 14px;
          letter-spacing: 0.2px;
          word-spacing: 0px;
          color: #000000;
          font-weight: 400;
          text-decoration: none solid rgb(68, 68, 68);
          font-style: normal;
          font-variant: normal;
          text-transform: none;

      }
      .cuadrado:hover {
  box-shadow: 0 14px 28px rgba(0,0,0,0.25), 0 10px 10px rgba(0,0,0,0.22);
}

.cuadrado2
      {
         width: 210px;
         height: 60px;
          bottom:-300px;
         position:absolute; 
         background:antiquewhite;
         
         border: 1px hidden #FFFFFF;
          border-radius: 7px 7px 7px 0px;

          box-shadow: 0 1px 3px rgba(0,0,0,0.12), 0 1px 2px rgba(0,0,0,0.24);
  transition: all 0.3s cubic-bezier(.25,.8,.25,1);

          font-family: HelveticaNeue;
          font-size: 14px;
          letter-spacing: 0.2px;
          word-spacing: 0px;
          color: #000000;
          font-weight: 400;
          text-decoration: none solid rgb(68, 68, 68);
          font-style: normal;
          font-variant: normal;
          text-transform: none;

      }
      .cuadrado2:hover {
  box-shadow: 0 14px 28px rgba(0,0,0,0.25), 0 10px 10px rgba(0,0,0,0.22);
}
</style>
  <script src="https://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>
    <%
    sText=Request.QueryString("txt")
    sID=Request.QueryString("id")
    %>
    <script>
      var alto;
      alto=screen.height;
    </script>

      
<div class="cuadrado" style="text-align: justify; padding: 5px;" >Puedes buscar más información en nuestra base de datos...</div>
<a href="https://www.propertyweb.eu/info/edificio/?id=<%= sID %>" target="_Blank" ><div class="cuadrado2" style="text-align: justify; padding: 5px;">Clic aqui para saber todo sobre <%=sText %></div></a>
<script>
  window.onload = function() {
  Up();

  
};
async function Up(){
  console.log(alto);
  
  alto=alto*0.21;
  $(".cuadrado").animate({"bottom": "+=" + alto + "px"}, "slow");
  await sleep(1000);

  Up2();
}
 
async function Up2(){
  await sleep(1000);
  console.log(alto);
  alto=alto+221;

  $(".cuadrado2").animate({"bottom": "+=" + alto + "px"}, "slow");
  
}
function Down(){
  $(".cuadrado").animate({"bottom": "-=100px"}, "slow");
}

function sleep(ms) {
  return new Promise(
    resolve => setTimeout(resolve, ms)
  );
}



 
</script>
 
</body>
</html>