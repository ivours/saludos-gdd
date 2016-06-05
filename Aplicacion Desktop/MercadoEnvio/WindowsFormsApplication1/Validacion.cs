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
        public static Boolean empiezaConCaracter(String texto)
        {
            return !texto.StartsWith(" ");
        }

        public static Boolean estaVacio(String texto)
        {
            return texto.Length.Equals(0);
        }

        public static Boolean esTrimestreMenorAlActual(int trimestre)
        {
            return trimestre < Fecha.getNroTrimestreDesdeDatetime(Fecha.getFechaActual());
        }

        public static void tieneFilaSeleccionada(DataGridView dataGridView)
        {
            if (dataGridView.SelectedRows.Count.Equals(0))
                throw new Exception("Debe seleccionar una fila de la tabla");
        }
    }
}
