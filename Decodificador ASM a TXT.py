import tkinter as tk
from tkinter import filedialog, messagebox
import os

def decodificar_instruccion(linea):
    """
    Decodifica una línea del archivo .asm a una instrucción de 32 bits y la divide en segmentos de 8 bits.
    """
    partes = [p.strip() for p in linea.strip().split(',')]
    if len(partes) != 6:
        raise ValueError(f"La línea no tiene el formato esperado: {linea}")

    opcode_mapeo = {
        'SUMA': '000000',
        'RESTA': '000001',
        'SLT': '000010',
        'SW': '000011'
    }
    instruccion = partes[0].upper()
    if instruccion not in opcode_mapeo:
        raise ValueError(f"Instrucción desconocida: {instruccion}")

    opcode = opcode_mapeo[instruccion]

    def num_a_binario(num_str, bits):
        try:
            num = int(num_str)
        except ValueError:
            raise ValueError(f"Valor numérico incorrecto: {num_str}")
        bin_str = format(num, f'0{bits}b')
        if len(bin_str) > bits:
            raise ValueError(f"El número {num} excede los {bits} bits permitidos")
        return bin_str.zfill(bits)

    try:
        op1 = num_a_binario(partes[1].replace('$', ''), 5)
        op2 = num_a_binario(partes[2].replace('$', ''), 5)
        op3 = num_a_binario(partes[3].replace('$', ''), 5)
        op4 = num_a_binario(partes[4].replace('$', ''), 5)  # Corregido a 5 bits
        op5 = num_a_binario(partes[5].replace('$', ''), 6)
    except Exception as e:
        raise ValueError(f"Error procesando operandos en la línea: {linea}\n{e}")

    instruccion_binaria = opcode + op1 + op2 + op3 + op4 + op5

    if len(instruccion_binaria) != 32:
        raise ValueError(f"La instrucción generada no es de 32 bits: {instruccion_binaria}")

    # Dividir en segmentos de 8 bits y unirlos en una sola cadena con saltos de línea
    segmentos = "\n".join([instruccion_binaria[i:i+8] for i in range(0, 32, 8)])
    return segmentos

def procesar_archivo(archivo_asm, archivo_txt):
    """
    Lee el archivo .asm, decodifica cada línea y guarda las instrucciones en segmentos de 8 bits en archivo_txt.
    """
    try:
        with open(archivo_asm, 'r', encoding='utf-8') as f_asm:
            lineas = f_asm.readlines()
    except FileNotFoundError:
        messagebox.showerror("Error", f"El archivo {archivo_asm} no se encontró.")
        return False

    instrucciones_binarias = []
    errores = []
    for num_linea, linea in enumerate(lineas, start=1):
        if not linea.strip() or linea.strip().startswith('#'):
            continue
        try:
            instr_bin = decodificar_instruccion(linea)
            instrucciones_binarias.append(instr_bin)
        except Exception as e:
            errores.append(f"Línea {num_linea}: {e}")

    try:
        with open(archivo_txt, 'w', encoding='utf-8') as f_txt:
            f_txt.write("\n".join(instrucciones_binarias))  # Une todas las instrucciones sin espacios extra
    except Exception as e:
        messagebox.showerror("Error", f"No se pudo escribir en el archivo de salida:\n{e}")
        return False

    if errores:
        mensaje = f"Se procesaron {len(instrucciones_binarias)} instrucciones.\n" \
                  f"Se encontraron algunos errores:\n" + "\n".join(errores)
        messagebox.showwarning("Proceso completado con errores", mensaje)
    else:
        messagebox.showinfo("Proceso completado", f"Se han procesado {len(instrucciones_binarias)} instrucciones correctamente.")
    return True

def seleccionar_archivo():
    archivo_asm = filedialog.askopenfilename(
        title="Selecciona el archivo .asm",
        filetypes=(("Archivos ASM", "*.asm"), ("Todos los archivos", "*.*"))
    )
    if archivo_asm:
        base, _ = os.path.splitext(archivo_asm)
        archivo_txt = base + "_binario.txt"
        if procesar_archivo(archivo_asm, archivo_txt):
            messagebox.showinfo("Archivo Guardado", f"El archivo convertido se ha guardado en:\n{archivo_txt}")

def crear_interfaz():
    ventana = tk.Tk()
    ventana.title("Decodificador ASM a Binario")
    ventana.geometry("400x150")

    etiqueta = tk.Label(ventana, text="Selecciona el archivo .asm a convertir:")
    etiqueta.pack(pady=10)

    boton_seleccionar = tk.Button(ventana, text="Seleccionar Archivo", command=seleccionar_archivo)
    boton_seleccionar.pack(pady=10)

    ventana.mainloop()

if __name__ == "__main__":
    crear_interfaz()
