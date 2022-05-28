##Desenvolvido por Robert Rocha :D

$ErrorActionPreference = 'Continue'

#Criação da variável de log do perfil

$logExclusão

# Obter todos os perfis presentes na máquina e armazenar na variável "perfis":

$perfis = Get-WmiObject Win32_UserProfile


#Perfis que tenha seu caminho iniciado em 'C:\Windows' não devem ser excluídos, muitas vezes sequer temos permissão para deletá-los, portanto, vamos criar um filtro para pegar apenas os perfis de usuário:

$perfis = $perfis | Where-Object LocalPath -notlike '*C:\Windows*'


#Agora iremos dar andamento no processo de exclusão de perfis iterando o array de perfis e passando o método 'Remove-WmiObject' para cada membro do array:


foreach($perfil in $perfis){

    ## Para que o usuário possa acompanhar melhor o que está ocorrendo, mostramos para ele qual perfil estamos deletando no momento. Para que fique mais elegante, vamos mostrar apenas o nome do usuário, omitindo o caminho. Utilizaremos o Split, para tanto.
    

    $usuario = $perfil.LocalPath.Split('\')[-1]

    "$usuario está tendo seu perfil excluído. Peço que aguarde um instante `n"

       
     $perfil | Remove-WmiObject
    

     $logExclusão = "Procedimento realizado em: '$usuario'.`n"

     

}


$logExclusão += "`nLog de erros: $Error"


$data = Get-Date -Format 'DD-MM-yyyy-hh-mm-ss'

if(Test-Path 'C:\Shell\Logs'){

    $logExclusão > "C:\Shell\Logs\Delecao-$data.txt"

}else{

    New-Item -Path 'C:\Shell\Logs' -ItemType 'Directory'

    $logExclusão > "C:\Shell\Logs\Delecao-$data.txt"

}
