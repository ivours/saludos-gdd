using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using WindowsFormsApplication1.Dominio;

namespace WindowsFormsApplication1.Facturas
{
    public partial class FacturaPublicacion : Form
    {
        int codigoFactura;
        int codigoPublicacion;
        String destinatario;
        DateTime fechaFacturacion;
        List<Item> itemsFactura;

        public FacturaPublicacion(List<Item> itemsFactura, int codigoFactura, int codigoPublicacion, String destinatario, DateTime fechaFacturacion)
        {
            InitializeComponent();
            this.itemsFactura = itemsFactura;
            this.codigoFactura = codigoFactura;
            this.codigoPublicacion = codigoPublicacion;
            this.destinatario = destinatario;
            this.fechaFacturacion = fechaFacturacion;
            this.inicializarCampos();
        }

        private void inicializarCampos()
        {
            textBox8.Text = this.codigoPublicacion.ToString();
            textBox1.Text = this.codigoFactura.ToString();
            textBox2.Text = this.destinatario;
            textBox3.Text = this.fechaFacturacion.ToString();
            textBox4.Text = this.itemsFactura[0].getImporte().ToString();
            textBox7.Text = this.itemsFactura[0].getImporte().ToString();
        }

        private void FacturaPublicacion_Load(object sender, EventArgs e)
        {

        }
    }
}
