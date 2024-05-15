enum PaymentStatus {
  Initiated('initiated'), // Add this line
  Pending('pending'),
  Authorized('authorized'),
  Captured('success'),
  Failed('failed'),
  Timeout('timeout');

  final String name;
  const PaymentStatus(this.name);
}

// extension PaymentStatusExtension on PaymentStatus {
//   String get name {
//     switch (this) {
//       case PaymentStatus.Initiated:
//         return 'initiated';
//       case PaymentStatus.Pending:
//         return 'pending';
//       case PaymentStatus.Authorized:
//         return 'Authorized';
//       case PaymentStatus.Captured:
//         return 'success';
//       case PaymentStatus.Failed:
//         return 'failed';
//       case PaymentStatus.Timeout:
//         return 'timeout';
//       default:
//         return '';
//     }
//   }
// }
