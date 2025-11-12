# .bashrc                                         
                                                  
# User specific aliases and functions             
                                                  
# Source global definitions                       
if [ -f /etc/bashrc ]; then                       
        . /etc/bashrc                             
fi                                                

#azul
#PS1="------------\n\033[1;37;44m{`hostname`}:\033[36m \w\033[0;0m \n\[\033[30;47m\][\[\033[31m\]\u\[\033[30;47m\]@:\W]$\[\033[00m\](\#)->" 

#verde
PS1="------------\n\033[1;37;42m{`hostname`}:\033[36m \w\033[0;0m \n\[\033[30;47m\][\[\033[31m\]\u\[\033[30;47m\]@:\W]$\[\033[00m\](\#)->" 

alias tailm='tail /var/log/messages'
alias tailmf='tailf /var/log/messages'
alias dmesg10='dmesg | tail -n 10' 
alias dmesg20='dmesg | tail -n 20' 

function ff() { find . -name '*'$1'*' ; }                 # find a file
function fe() { find . -name '*'$1'*' -exec $2 {} \; ; }  # find a file and run $2 on it 

function meml(){
echo sqrt\( \($(free -b | awk '/Mem/{print $2}') \* 0.50 \)/8 \) | bc 
}

# Store 5000 commands in history buffer
export HISTSIZE=5000
 
# Store 5000 commands in history FILE 
export HISTFILESIZE=5000      
 
# Avoid duplicates in hisotry 
export HISTIGNORE='&:[ ]*'


# source /opt/intel/parallel_studio_xe_2020/psxevars.sh 
