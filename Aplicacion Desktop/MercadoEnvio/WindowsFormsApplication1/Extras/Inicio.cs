using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WindowsFormsApplication1.Extras
{
    class Inicio
    {
        public static void actualizarEstadosDePublicaciones()
        {
            SQLManager manager = new SQLManager();
            manager.generarSP("actualizarEstadosDePublicaciones");
            manager.ejecutarSP();
        }

        public static void adjudicarSubastas()
        {
            SQLManager manager = new SQLManager();
            manager.generarSP("adjudicarSubastas");
            manager.ejecutarSP();
        }
    }
}
