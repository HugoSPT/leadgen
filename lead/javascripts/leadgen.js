$(document).ready(function(){
    $('.first').css({ marginLeft : "10px"});
    
    $('.datepicker').datepicker({ dateFormat: 'dd/mm/yy', viewMode: 0 });
    
    initialize();
    
    $("#submit").click(function(event){
        var id = "";
        var div = document.getElementById("validationErrors");
        div.setAttribute("style", "width: 780px; margin-top: 10px; position: relative; float: left; border: solid 1px; border-color: #ff0000; border-radius: 10px; padding: 20px 0px 0px 20px; color: #ff0000;");
        if(div != null)
            div.innerHTML = "";
        $(".required").each(function() {
            if ($(this).val() == ""){
                id += errorMessage($(this).attr('id'));
                $(this).css({'border-color': '#FF0000'});
                $(this).addClass("empty");
            }else if($(this).hasClass("empty")){
                $(this).removeClass("empty");
                $(this).css({'border-color': '#CCCCCC'});
            }
        });
        if(id != ""){
            $("#validationErrors").append(id + "\n");
            event.preventDefault();
        }
		else{ 
			//serialize form
			var data = {};
			$("input, select").each(function() {
			    data[$(this).prop("name")] = $(this).val();
			});
			var serializedArray = JSON.stringify(data);
                        
			//ajax call
                        $.ajax({
                            url : "ajax/firebase_ajax.php",
                            type: 'POST',
                            data: serializedArray,
                            success: function(response){
                                //redirect

                            },
                            error: function (xhr, ajaxOptions, thrownError) {
                               alert(xhr.status);
                               alert(xhr.responseText);
                               alert(thrownError);
                            } 
                        });
		}
    });
});

function initialize(){
    var select = document.getElementById("quantia");
    var value = 100;
    while(value <= 1000){
        select.options[select.options.length] = new Option(value, value);
        value += 50;
    }
}

function errorMessage(field){
    if(field == "quantia")
        return "<p>Informa��es Cr�dito: Insira a quantia pretendida;</p>";
    else if(field == "prazo")
        return "<p>Informa��es Cr�dito: Insira o tipo de prazo;</p>";
    else if(field == "datepicker")
        return "<p>Informa��es Cr�dito: Insira a data de pagamento;</p>";
    else if(field == "primeiroNome")
        return "<p>Informa��es Pessoais: Insira o seu primeiro nome;</p>";
    else if(field == "ultimoNome")
        return "<p>Informa��es Pessoais: Insira o seu sobrenome;</p>";
    else if(field == "dia" || field == "mes" || field == "ano")
        return "<p>Informa��es Pessoais: Insira data de nascimento;</p>";
    else if(field == "morada")
        return "<p>Informa��es Pessoais: Insira um endere�o;</p>";
    else if(field == "cidade")
        return "<p>Informa��es Pessoais: Insira uma cidade;</p>";
    else if(field == "cep")
        return "<p>Informa��es Pessoais: Insira um CEP;</p>";
    else if(field == "telefone")
        return "<p>Informa��es Pessoais: Insira um n�mero de telefone;</p>";
    else if(field == "telemovel")
        return "<p>Informa��es Pessoais: Insira um n�mero de telem�vel;</p>";
    else if(field == "email")
        return "<p>Informa��es Pessoais: Insira um e-mail;</p>";
    else if(field == "situacaoProfissional")
        return "<p>Informa��es Profissionais: Insira a situa��o profissional;</p>";
    else if(field == "salario")
        return "<p>Informa��es Profissionais: Insira o seu sal�rio;</p>";
    else if(field == "empregador")
        return "<p>Informa��es Pessoais: Insira o nome do seu empregador;</p>";
    else if(field == "contrato")
        return "<p>Informa��es Profissionais: Insira o seu tipo de contrato;";
    else if(field == "periodo")
        return "<p>Informa��es Profissionais: Insira a periodicidade do seu sal�rio;";
    else if(field == "banco")
        return "<p>Informa��es Banc�rias: Insira o nome so seu banco;</p>";
    else if(field == "conta")
        return "<p>Informa��es Banc�rias: Insira o n�mero de conta;</p>";
    else if(field == "cartao")
        return "<p>Informa��es Banc�rias: Insira o seu tipo de cart�o;</p>";
    return "";
}
    
function validateEmail(mail){  
 
    }
