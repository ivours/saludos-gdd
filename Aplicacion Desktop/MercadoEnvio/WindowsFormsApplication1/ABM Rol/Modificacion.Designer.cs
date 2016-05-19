namespace WindowsFormsApplication1.ABM_Rol
{
    partial class Modificacion
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.labelNuevoNombre = new System.Windows.Forms.Label();
            this.textboxNuevoNombre = new System.Windows.Forms.TextBox();
            this.cListBoxFuncionalidades = new System.Windows.Forms.CheckedListBox();
            this.labelFuncionalidades = new System.Windows.Forms.Label();
            this.labelNombreActual = new System.Windows.Forms.Label();
            this.textboxNombreActual = new System.Windows.Forms.TextBox();
            this.checkboxHabilitar = new System.Windows.Forms.CheckBox();
            this.buttonGuardar = new System.Windows.Forms.Button();
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.button1 = new System.Windows.Forms.Button();
            this.groupBox1.SuspendLayout();
            this.SuspendLayout();
            // 
            // labelNuevoNombre
            // 
            this.labelNuevoNombre.AutoSize = true;
            this.labelNuevoNombre.Location = new System.Drawing.Point(6, 68);
            this.labelNuevoNombre.Name = "labelNuevoNombre";
            this.labelNuevoNombre.Size = new System.Drawing.Size(77, 13);
            this.labelNuevoNombre.TabIndex = 0;
            this.labelNuevoNombre.Text = "Nuevo nombre";
            // 
            // textboxNuevoNombre
            // 
            this.textboxNuevoNombre.Location = new System.Drawing.Point(118, 65);
            this.textboxNuevoNombre.Name = "textboxNuevoNombre";
            this.textboxNuevoNombre.Size = new System.Drawing.Size(172, 20);
            this.textboxNuevoNombre.TabIndex = 1;
            // 
            // cListBoxFuncionalidades
            // 
            this.cListBoxFuncionalidades.FormattingEnabled = true;
            this.cListBoxFuncionalidades.Location = new System.Drawing.Point(118, 109);
            this.cListBoxFuncionalidades.Name = "cListBoxFuncionalidades";
            this.cListBoxFuncionalidades.Size = new System.Drawing.Size(172, 94);
            this.cListBoxFuncionalidades.TabIndex = 2;
            // 
            // labelFuncionalidades
            // 
            this.labelFuncionalidades.AutoSize = true;
            this.labelFuncionalidades.Location = new System.Drawing.Point(6, 109);
            this.labelFuncionalidades.Name = "labelFuncionalidades";
            this.labelFuncionalidades.Size = new System.Drawing.Size(84, 13);
            this.labelFuncionalidades.TabIndex = 3;
            this.labelFuncionalidades.Text = "Funcionalidades";
            // 
            // labelNombreActual
            // 
            this.labelNombreActual.AutoSize = true;
            this.labelNombreActual.Location = new System.Drawing.Point(6, 26);
            this.labelNombreActual.Name = "labelNombreActual";
            this.labelNombreActual.Size = new System.Drawing.Size(76, 13);
            this.labelNombreActual.TabIndex = 4;
            this.labelNombreActual.Text = "Nombre actual";
            // 
            // textboxNombreActual
            // 
            this.textboxNombreActual.Location = new System.Drawing.Point(118, 23);
            this.textboxNombreActual.Name = "textboxNombreActual";
            this.textboxNombreActual.ReadOnly = true;
            this.textboxNombreActual.Size = new System.Drawing.Size(172, 20);
            this.textboxNombreActual.TabIndex = 5;
            // 
            // checkboxHabilitar
            // 
            this.checkboxHabilitar.AutoSize = true;
            this.checkboxHabilitar.Location = new System.Drawing.Point(9, 220);
            this.checkboxHabilitar.Name = "checkboxHabilitar";
            this.checkboxHabilitar.Size = new System.Drawing.Size(104, 17);
            this.checkboxHabilitar.TabIndex = 6;
            this.checkboxHabilitar.Text = "Volver a habilitar";
            this.checkboxHabilitar.UseVisualStyleBackColor = true;
            // 
            // buttonGuardar
            // 
            this.buttonGuardar.Location = new System.Drawing.Point(244, 269);
            this.buttonGuardar.Name = "buttonGuardar";
            this.buttonGuardar.Size = new System.Drawing.Size(75, 23);
            this.buttonGuardar.TabIndex = 7;
            this.buttonGuardar.Text = "Guardar";
            this.buttonGuardar.UseVisualStyleBackColor = true;
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.cListBoxFuncionalidades);
            this.groupBox1.Controls.Add(this.labelNuevoNombre);
            this.groupBox1.Controls.Add(this.checkboxHabilitar);
            this.groupBox1.Controls.Add(this.textboxNuevoNombre);
            this.groupBox1.Controls.Add(this.textboxNombreActual);
            this.groupBox1.Controls.Add(this.labelFuncionalidades);
            this.groupBox1.Controls.Add(this.labelNombreActual);
            this.groupBox1.Location = new System.Drawing.Point(12, 12);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(307, 251);
            this.groupBox1.TabIndex = 8;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "Datos del rol";
            // 
            // button1
            // 
            this.button1.Location = new System.Drawing.Point(12, 269);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(75, 23);
            this.button1.TabIndex = 9;
            this.button1.Text = "Limpiar";
            this.button1.UseVisualStyleBackColor = true;
            // 
            // Modificacion
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(337, 302);
            this.Controls.Add(this.button1);
            this.Controls.Add(this.groupBox1);
            this.Controls.Add(this.buttonGuardar);
            this.Name = "Modificacion";
            this.Text = "Modificar rol";
            this.groupBox1.ResumeLayout(false);
            this.groupBox1.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Label labelNuevoNombre;
        private System.Windows.Forms.TextBox textboxNuevoNombre;
        private System.Windows.Forms.CheckedListBox cListBoxFuncionalidades;
        private System.Windows.Forms.Label labelFuncionalidades;
        private System.Windows.Forms.Label labelNombreActual;
        private System.Windows.Forms.TextBox textboxNombreActual;
        private System.Windows.Forms.CheckBox checkboxHabilitar;
        private System.Windows.Forms.Button buttonGuardar;
        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.Button button1;
    }
}