# Um dockerfile sempre deve começar importando a imagem de base.
# Assim, escrevemos 'python' para o nome da imagem e '3.12-slim' para a versão que aceita TensorFlow.
FROM python:3.12-slim

# Para lançar nosso código em Python, devemos importá-lo em nossa imagem.
# Usamos para isso a palavra-chave 'COPY'.
# O primeiro parâmetro, 'main.ipynb', é o nome do arquivo no host.
# O segundo parâmetro, '/', é o caminho onde colocar o arquivo na imagem.
# Aqui, colocamos o arquivo na pasta raiz da imagem.
COPY main.py /

# Precisamos definir o comando para lançar quando rodarmos a imagem.
# Usamos a palavra-chave 'CMD' para isso.
# O comando a seguir executará "python ./main.py".
CMD [ "python", "./main.py" ]