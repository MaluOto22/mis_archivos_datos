import streamlit as st
import pandas as pd
import matplotlib.pyplot as plt

def introduccion():
    st.title("Dataset Titanic (Filtrado)")
    st.write(df_filtrado.head())
    texto = """
    El Titanic fue un transatlántico británico considerado el más grande y lujoso de su época. 
    Fue construido por la compañía White Star Line y partió en su viaje inaugural el 10 de abril de 1912 desde Southampton hacia Nueva York. 
    A pesar de ser considerado prácticamente insumergible, el 14 de abril chocó contra un iceberg en el océano Atlántico. 
    El impacto causó graves daños en el casco y el barco se hundió en la madrugada del 15 de abril. 
    Más de 1,500 personas murieron, lo que convirtió el desastre en una de las tragedias marítimas más recordadas de la historia.
    """
    st.write(texto)

def estadisticas():
    st.title("Estadísticas básicas (Filtrado)")
    st.write(df_filtrado.describe())
    
def graficas():    
    st.title("Gráficas (Filtrado)")
    conteo = df_filtrado['Survived'].value_counts()
    fig, ax = plt.subplots()
    ax.bar(conteo.index, conteo.values)
    ax.set_xlabel("Supervivencia (0 = No, 1 = Sí)")
    ax.set_ylabel("Número de pasajeros")
    ax.set_title("Supervivientes")
    st.pyplot(fig)    

# Parte principal del programa
df = pd.read_csv('trainLimpio.csv')

#Colocación de imagen y Título
col1, col2 = st.columns([1, 4])
with col1:
    st.image("titanic.jpg", width=100)

with col2:
    st.title("Dashboard Titanic")

# ---- FILTROS ----
st.sidebar.header("Filtros")

# Edad (rango)
edad_min, edad_max = st.sidebar.slider(
    "Edad",
    int(df['Age'].min()),
    int(df['Age'].max()),
    (int(df['Age'].min()), int(df['Age'].max()))
)

# Sexo
sexo_opciones = st.sidebar.multiselect(
    "Sexo",
    options=df['Sex'].unique(),
    default=df['Sex'].unique()
)

# Clase
clase_opciones = st.sidebar.multiselect(
    "Clase (Pclass)",
    options=df['Pclass'].unique(),
    default=df['Pclass'].unique()
)

# Aplicar filtros
df_filtrado = df[
    (df['Age'] >= edad_min) &
    (df['Age'] <= edad_max) &
    (df['Sex'].isin(sexo_opciones)) &
    (df['Pclass'].isin(clase_opciones))
]

# ---- MENÚ ----
menu = st.sidebar.selectbox("Menú",["Introducción", "Estadísticas", "Gráficas"])

# ---- CONTENIDO ----

if menu == "Introducción":
    introduccion()

elif menu == "Estadísticas":
    estadisticas()

elif menu == "Gráficas":
    graficas()