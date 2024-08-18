# Use a imagem oficial do Ruby como base
FROM ruby:3.3.4-slim

# Instale as dependências do sistema
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

# Configure o diretório de trabalho
WORKDIR /myapp

# Adicione o Gemfile e o Gemfile.lock
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock

# Instale as gemas
RUN bundle install

# Adicione o restante do código da aplicação
COPY . /myapp

# Exponha a porta 3000 para o servidor Rails
EXPOSE 3000

# Comando para iniciar o servidor Rails
CMD ["rails", "server", "-b", "0.0.0.0"]
