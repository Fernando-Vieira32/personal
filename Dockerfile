# Use a imagem oficial do Ruby como base
FROM ruby:3.3.4-slim as base

# Configure o diretório de trabalho
WORKDIR /myapp

# Set production environment
ENV BUNDLE_WITHOUT="development"

# Instale as dependências do sistema
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    build-essential \
    libpq-dev libvips \
    bash bash-completion \
    libffi-dev tzdata postgresql \
    nodejs npm yarn \
    wget postgresql-client \
    apt-transport-https \
    ca-certificates curl gnupg-agent gnupg gnupg2 \
    software-properties-common && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Install libssl
RUN cd /tmp && \
    wget http://nz2.archive.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.1f-1ubuntu2_amd64.deb && \
    dpkg -i libssl1.1_1.1.1f-1ubuntu2_amd64.deb && \
    rm libssl1.1_1.1.1f-1ubuntu2_amd64.deb && cd /

# Throw-away build stage to reduce size of final image
FROM base as build

# Adicione o Gemfile e o Gemfile.lock
COPY Gemfile Gemfile.lock ./

# Instale as gems
RUN bundle install --without development test

# Copy application code
COPY . .

# Verifique a instalação do Rails
RUN bundle exec rails -v

# Final stage for app image
FROM base

# Copie os artefatos construídos: gems, aplicação
COPY --from=build /usr/local/bundle /usr/local/bundle
COPY --from=build /myapp /myapp

# Verifique a presença do executável Rails
RUN which rails

# Exponha a porta 3000 para o servidor Rails
EXPOSE 3000

# Comando para iniciar o servidor Rails
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
