using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using WindowsFormsApplication1.Extras;

namespace WindowsFormsApplication1.ABM_Visibilidad
{
    public partial class BajaVisibilidad : Form
    {
        public BajaVisibilidad()
        {
            InitializeComponent();
            ConfiguradorVentana.configurarVentana(this);
        }

        public void bajaVisibilidad(String nombreVisibilidad)
        {

                SQLManager manager = new SQLManager().generarSP("bajaVisibilidad")
                                     .agregarStringSP("@nombre_visibilidad", nombreVisibilidad);

                manager.ejecutarSP();
        }

    }
}
