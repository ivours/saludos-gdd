using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace WindowsFormsApplication1.Extras
{
    class ConfiguradorVentana
    {
        public static void configurarVentana(Form form)
        {
            form.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog;
            form.MaximizeBox = false;
        }

    }
}
