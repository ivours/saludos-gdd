using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace WindowsFormsApplication1.Facturas
{
    public partial class ListadoFacturas : Form
    {
        public ListadoFacturas()
        {
            InitializeComponent();
        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {

        }

        //TODO: Ver si hace falta validar los otros campos
        private void validarCampos()
        {
            this.validarIntervaloFechas();
            this.validarIntervaloImportes();
        }

        private void validarIntervaloFechas()
        {
            if (dateTimePicker1.Value.CompareTo(dateTimePicker2.Value) > 0)
                throw new Exception("El extremo inferior del intervalo de fechas no puede ser mayor al extremo superior");

            if (dateTimePicker1.Value.CompareTo(Dominio.Fecha.getFechaActual()) > 0)
                throw new Exception("La fecha del extremo inferior del intervalo de fechas no puede ser mayor a la fecha actual");

            if (dateTimePicker2.Value.CompareTo(Dominio.Fecha.getFechaActual()) > 0)
                throw new Exception("La fecha del extremo superior del intervalo de fechas no puede ser mayor a la fecha actual");
        }

        private void validarIntervaloImportes()
        {
            if (numericUpDown1.Value > numericUpDown2.Value)
                throw new Exception("El extremo inferior del intervalo de importes no puede ser mayor al extremo superior");
        }
    }
}
