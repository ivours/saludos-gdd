using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace WindowsFormsApplication1.Listado_Estadistico
{
    public partial class ListadoRubros : Form
    {
        ListadoEstadistico listadoEstadistico;

        public ListadoRubros(ListadoEstadistico listadoEstadistico)
        {
            InitializeComponent();
            this.listadoEstadistico = listadoEstadistico;
        }
    }
}
