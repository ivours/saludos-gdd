using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WindowsFormsApplication1.Extras
{
    class ConcatenadorDeStrings
    {
        public static String concatenarStringsSeparadosConComa(List<String> listaDeStrings)
        {
            String stringsConcatenados = "";

            for (int i = 0; i < listaDeStrings.Count; i++)
            {
                if (!i.Equals(listaDeStrings.Count - 1))
                    stringsConcatenados = stringsConcatenados + "'" + listaDeStrings[i] + "'" + ",";
                else
                    stringsConcatenados = stringsConcatenados + "'" + listaDeStrings[i] + "'";
            }

            return stringsConcatenados;
        }
    }
}
