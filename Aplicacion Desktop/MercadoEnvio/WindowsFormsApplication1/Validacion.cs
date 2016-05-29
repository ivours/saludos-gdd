using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Windows.Forms;

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
    }
}
