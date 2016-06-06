using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using WindowsFormsApplication1.Dominio;

namespace WindowsFormsApplication1
{
    class Validacion
    {
        //Validaciones de strings

        public static Boolean empiezaConCaracter(String texto)
        {
            return !texto.StartsWith(" ");
        }

        public static Boolean contieneEspacio(String texto)
        {
            return texto.Contains(" ");
        }

        public static Boolean contieneSoloLetras(String texto)
        {
            return (texto.All(caracter => Char.IsLetter(caracter)));
        }

        public static Boolean contieneSoloLetrasOEspacios(String texto)
        {
            return (texto.All(caracter => Char.IsLetter(caracter) || Char.IsWhiteSpace(caracter)));
        }

        public static Boolean contieneSoloNumeros(String texto)
        {
            return (texto.All(caracter => Char.IsNumber(caracter)));
        }

        public static Boolean estaVacio(String texto)
        {
            return texto.Length.Equals(0);
        }

        public static Boolean tieneLongitudMayorOIgualA(String texto, int longitudMinima)
        {
            return texto.Length >= longitudMinima;
        }

        public static Boolean tieneFormatoDeCuit(String texto)
        {
            int i = 0;

            for ( ; i < 2; i++)
            {
                if (!Char.IsNumber(texto[i]))
                    return false;
            }

            if (!texto[i].Equals('-'))
                return false;

            for (i++; i < 11; i++)
            {
                if(!Char.IsNumber(texto[i]))
                    return false;
            }

            if (!texto[i].Equals('-'))
                return false;

            for (i++; i < 14; i++)
            {
                if (!Char.IsNumber(texto[i]))
                    return false;
            }

            return true;
        }

        //Validaciones de fechas

        public static Boolean esTrimestreMenorAlActual(int trimestre)
        {
            return trimestre < Fecha.getNroTrimestreDesdeDatetime(Fecha.getFechaActual());
        }

        public static void tieneFilaSeleccionada(DataGridView dataGridView)
        {
            if (dataGridView.SelectedRows.Count.Equals(0))
                throw new Exception("Debe seleccionar una fila de la tabla");
        }

        public static Boolean esFechaMayorALaActual(DateTime fecha)
        {
            return fecha.CompareTo(Fecha.getFechaActual()) > 0;
        }
    }
}
