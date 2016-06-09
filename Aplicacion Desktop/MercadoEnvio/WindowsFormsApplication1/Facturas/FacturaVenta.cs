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
    public partial class FacturaVenta : Form
    {
        int codigoFactura;
        int codigoPublicacion;
        String destinatario;
        DateTime fechaFacturacion;
        List<Item> itemsFactura;

        public FacturaVenta(List<Item> itemsFactura, int codigoFactura, int codigoPublicacion, String destinatario, DateTime fechaFacturacion)
        {
            InitializeComponent();
            this.itemsFactura = itemsFactura;
            this.codigoFactura = codigoFactura;
            this.codigoPublicacion = codigoPublicacion;
            this.destinatario = destinatario;
            this.fechaFacturacion = fechaFacturacion;
            this.inicializarCampos();
        }

        //TODO: Ver como es el formato de descripcion de los items
        private void inicializarCampos()
        {
            decimal total = 0;

            textBox8.Text = this.codigoPublicacion.ToString();
            textBox1.Text = this.codigoFactura.ToString();
            textBox2.Text = this.destinatario;
            textBox3.Text = this.fechaFacturacion.ToString();

            for (int i = 0; i < itemsFactura.Count(); i++)
            {
                Item item = itemsFactura[i];

                if (item.getDescripcion().Equals("Venta")) //TODO: Chequear aca
                {
                    textBox4.Text = item.getImporte().ToString();
                    textBox5.Text = item.getCantidad().ToString();

                    total += item.getImporte() * item.getCantidad();
                }
                else
                {
                    if (item.getDescripcion().Equals("Envio")) //TODO: Chequear aca
                    {
                        textBox6.Text = item.getImporte().ToString();

                        total += item.getImporte();
                    }
                }
            }

            textBox7.Text = total.ToString();

        }
    }
}
