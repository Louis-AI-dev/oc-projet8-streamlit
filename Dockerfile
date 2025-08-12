# Image Python légère
FROM python:3.12-slim

# Empêcher Python de créer des .pyc et activer logs immédiats
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Dossier de travail
WORKDIR /app

# Installer dépendances système minimales
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
 && rm -rf /var/lib/apt/lists/*

# Copier les dépendances Python
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copier tout le code de l'app
COPY . .

# Exposer un port par défaut (utile en local)
EXPOSE 8501

# Lancer Streamlit (Render utilisera $PORT)
CMD ["sh", "-c", "streamlit run app.py --server.port ${PORT:-8501} --server.address 0.0.0.0"]
