'use client';

export default function Error({ error, reset }: { error: Error & { digest?: string }; reset: () => void }) {
  return (
    <div style={{ padding: 24, fontFamily: 'system-ui, sans-serif' }}>
      <h1 style={{ marginBottom: 12 }}>页面加载失败</h1>
      <p style={{ marginBottom: 16, color: '#666' }}>{error.message || '发生了未知错误。'}</p>
      <button
        type="button"
        onClick={() => reset()}
        style={{
          padding: '8px 14px',
          borderRadius: 8,
          border: '1px solid #ccc',
          background: '#fff',
          cursor: 'pointer',
        }}
      >
        重试
      </button>
    </div>
  );
}