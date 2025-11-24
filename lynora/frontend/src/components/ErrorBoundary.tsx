import React, { Component, ErrorInfo, ReactNode } from 'react';

interface Props {
  children: ReactNode;
}

interface State {
  hasError: boolean;
  error: Error | null;
  errorInfo: ErrorInfo | null;
}

class ErrorBoundary extends Component<Props, State> {
  constructor(props: Props) {
    super(props);
    this.state = {
      hasError: false,
      error: null,
      errorInfo: null,
    };
  }

  static getDerivedStateFromError(error: Error): State {
    return {
      hasError: true,
      error,
      errorInfo: null,
    };
  }

  componentDidCatch(error: Error, errorInfo: ErrorInfo) {
    console.error('ErrorBoundary caught an error:', error, errorInfo);
    this.setState({
      error,
      errorInfo,
    });
  }

  render() {
    if (this.state.hasError) {
      return (
        <div className="min-h-screen bg-black text-white flex items-center justify-center p-4">
          <div className="max-w-2xl w-full bg-gray-900 rounded-lg p-6 border border-red-500">
            <h1 className="text-2xl font-bold text-red-500 mb-4">
              ⚠️ Bir Hata Oluştu
            </h1>
            <p className="text-gray-300 mb-4">
              Uygulama yüklenirken bir hata oluştu. Lütfen sayfayı yenileyin veya aşağıdaki hata detaylarını kontrol edin.
            </p>
            
            {this.state.error && (
              <div className="mb-4">
                <h2 className="text-lg font-semibold text-red-400 mb-2">
                  Hata Mesajı:
                </h2>
                <pre className="bg-gray-800 p-4 rounded text-sm text-red-300 overflow-auto">
                  {this.state.error.toString()}
                </pre>
              </div>
            )}

            {this.state.errorInfo && (
              <div className="mb-4">
                <h2 className="text-lg font-semibold text-red-400 mb-2">
                  Hata Detayları:
                </h2>
                <pre className="bg-gray-800 p-4 rounded text-xs text-gray-400 overflow-auto max-h-64">
                  {this.state.errorInfo.componentStack}
                </pre>
              </div>
            )}

            <div className="flex gap-4 mt-6">
              <button
                onClick={() => window.location.reload()}
                className="px-4 py-2 bg-blue-600 hover:bg-blue-700 text-white rounded-lg transition-colors"
              >
                Sayfayı Yenile
              </button>
              <button
                onClick={() => this.setState({ hasError: false, error: null, errorInfo: null })}
                className="px-4 py-2 bg-gray-700 hover:bg-gray-600 text-white rounded-lg transition-colors"
              >
                Tekrar Dene
              </button>
            </div>

            <div className="mt-6 pt-6 border-t border-gray-700">
              <h3 className="text-sm font-semibold text-gray-400 mb-2">
                Olası Çözümler:
              </h3>
              <ul className="text-sm text-gray-500 space-y-1 list-disc list-inside">
                <li>Tarayıcı konsolunu açın (F12) ve hata mesajlarını kontrol edin</li>
                <li>Sayfayı yenileyin (Ctrl+R veya Cmd+R)</li>
                <li>Tarayıcı önbelleğini temizleyin</li>
                <li>Eğer sorun devam ederse, lütfen geliştiriciye bildirin</li>
              </ul>
            </div>
          </div>
        </div>
      );
    }

    return this.props.children;
  }
}

export default ErrorBoundary;

